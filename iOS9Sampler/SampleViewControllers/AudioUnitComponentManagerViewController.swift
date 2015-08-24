//
//  AudioUnitComponentManagerViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 2015/06/21.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit
import AVFoundation
import CoreAudioKit


class AudioUnitComponentManagerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    var viewBtn: UIBarButtonItem!
    
    private var items = [AVAudioUnitComponent]()

    private let engine = AVAudioEngine()
    private let player = AVAudioPlayerNode()
    private var file: AVAudioFile?

    /// The currently selected `AUAudioUnit` effect, if any.
    var audioUnit: AUAudioUnit?
    /// The audio unit's presets.
    var presetList = [AUAudioUnitPreset]()
    /// Engine's effect node.
    private var effect: AVAudioUnit?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewBtn = UIBarButtonItem(
            title: "ShowAUVC",
            style: UIBarButtonItemStyle.Plain,
            target: self, action: "viewBtnTapped:")
        self.navigationItem.setRightBarButtonItem(viewBtn, animated: false)
        viewBtn.enabled = false
        
        // setup engine and player
        engine.attachNode(player)
        guard let fileURL = NSBundle.mainBundle().URLForResource("drumLoop", withExtension: "caf") else {
            fatalError("\"drumLoop.caf\" file not found.")
        }
        do {
            let file = try AVAudioFile(forReading: fileURL)
            self.file = file
            engine.connect(player, to: engine.mainMixerNode, format: file.processingFormat)
        }
        catch {
            fatalError("Could not create AVAudioFile instance. error: \(error).")
        }

        // extract available effects
        var anyEffectDescription = AudioComponentDescription()
        anyEffectDescription.componentType = kAudioUnitType_Effect
        anyEffectDescription.componentSubType = 0
        anyEffectDescription.componentManufacturer = 0
        anyEffectDescription.componentFlags = 0
        anyEffectDescription.componentFlagsMask = 0
        
        items = AVAudioUnitComponentManager.sharedAudioUnitComponentManager()
            .componentsMatchingDescription(anyEffectDescription)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Schedule buffers on the player.
        self.scheduleLoop()
        
        // Start the engine.
        do {
            try self.engine.start()
        }
        catch {
            fatalError("Could not start engine. error: \(error).")
        }

        self.player.play()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.player.stop()
        self.engine.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    private func scheduleLoop() {
        guard let file = file else {
            fatalError("`file` must not be nil in \(__FUNCTION__).")
        }
        
        player.scheduleFile(file, atTime: nil) {
            self.scheduleLoop()
        }
    }

    private func selectEffectWithComponentDescription(componentDescription: AudioComponentDescription?, completionHandler: (Void -> Void) = {}) {
        
        // Internal function to resume playing and call the completion handler.
        func done() {
            player.play()
            completionHandler()
        }
        
        /*
        Pause the player before re-wiring it. (It is not simple to keep it
        playing across an effect insertion or deletion.)
        */
        player.pause()
        
        // Destroy any pre-existing effect.
        if effect != nil {
            // We have player -> effect -> mixer. Break both connections.
            engine.disconnectNodeInput(effect!)
            engine.disconnectNodeInput(engine.mainMixerNode)
            
            // Connect player -> mixer.
            engine.connect(player, to: engine.mainMixerNode, format: file!.processingFormat)
            
            // We're done with the effect; release all references.
            engine.detachNode(effect!)
            
            effect = nil
            audioUnit = nil
            presetList = [AUAudioUnitPreset]()
        }
        
        // Insert the new effect, if any.
        if let componentDescription = componentDescription {
            AVAudioUnit.instantiateWithComponentDescription(componentDescription, options: []) { avAudioUnit, error in
                guard let avAudioUnitEffect = avAudioUnit else { return }
                
                self.effect = avAudioUnitEffect
                self.engine.attachNode(avAudioUnitEffect)
                
                // Disconnect player -> mixer.
                self.engine.disconnectNodeInput(self.engine.mainMixerNode)
                
                // Connect player -> effect -> mixer.
                self.engine.connect(self.player, to: avAudioUnitEffect, format: self.file!.processingFormat)
                self.engine.connect(avAudioUnitEffect, to: self.engine.mainMixerNode, format: self.file!.processingFormat)
                
                self.audioUnit = avAudioUnitEffect.AUAudioUnit
                self.presetList = avAudioUnitEffect.AUAudioUnit.factoryPresets ?? []
                
                self.audioUnit?.requestViewControllerWithCompletionHandler { [weak self] viewController in
                    guard let strongSelf = self else { return }

                    strongSelf.viewBtn.enabled = viewController != nil ? true : false
                }

                done()
            }
        }
        else {
            done()
        }
    }

    
    // =========================================================================
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel!.text = "No Effect"
            cell.detailTextLabel!.text = ""
        }
        else {
            let auComponent = items[indexPath.row - 1]
            cell.textLabel!.text = auComponent.name
            cell.detailTextLabel!.text = auComponent.manufacturerName
        }
        
        return cell
    }
    
    
    // =========================================================================
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let auComponent: AVAudioUnitComponent?

        if indexPath.row == 0 {
            // no effect
            auComponent = nil
        }
        else {
            auComponent = items[indexPath.row - 1]
        }
        
        self.selectEffectWithComponentDescription(
            auComponent?.audioComponentDescription) { () -> Void in
        }

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    // =========================================================================
    // MARK: - Actions
    
    func viewBtnTapped(sender: AnyObject) {

        // close
        if self.childViewControllers.count > 0 {
            let childViewController = childViewControllers.first!
            childViewController.willMoveToParentViewController(nil)
            childViewController.view.removeFromSuperview()
            childViewController.removeFromParentViewController()
            
            viewBtn.title = "ShowAUVC"
            return
        }

        // open
        self.audioUnit?.requestViewControllerWithCompletionHandler { [weak self] viewController in
            guard let strongSelf = self else { return }
            guard let viewController = viewController, view = viewController.view else { return }

            strongSelf.addChildViewController(viewController)
            let parentRect = strongSelf.view.bounds
            view.frame = CGRectMake(
                0,
                parentRect.size.height / 2,
                parentRect.size.width,
                parentRect.size.height / 2)

            strongSelf.view.addSubview(view)
            viewController.didMoveToParentViewController(self)
            
            strongSelf.viewBtn.title = "CloseAUVC"
        }
    }
}
