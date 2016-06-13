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

extension AudioComponent {
    static func anyEffectDescription() -> AudioComponentDescription {
        var anyEffectDescription = AudioComponentDescription()
        anyEffectDescription.componentType = kAudioUnitType_Effect
        anyEffectDescription.componentSubType = 0
        anyEffectDescription.componentManufacturer = 0
        anyEffectDescription.componentFlags = 0
        anyEffectDescription.componentFlagsMask = 0
        return anyEffectDescription
    }
}

class AudioUnitComponentManagerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak private var tableView: UITableView!
    private var viewBtn: UIBarButtonItem!
    
    private var items = [AVAudioUnitComponent]()

    private var engine = AudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewBtn = UIBarButtonItem(
            title: "ShowAUVC",
            style: UIBarButtonItemStyle.Plain,
            target: self, action: #selector(AudioUnitComponentManagerViewController.viewBtnTapped(_:)))
        navigationItem.setRightBarButtonItem(viewBtn, animated: false)
        viewBtn.enabled = false
        
        // extract available effects
        items = AVAudioUnitComponentManager.sharedAudioUnitComponentManager()
            .componentsMatchingDescription(AudioComponent.anyEffectDescription())
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        engine.start()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        engine.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        } else {
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
        } else {
            auComponent = items[indexPath.row - 1]
        }
        
        engine.selectEffectWithComponentDescription(auComponent?.audioComponentDescription) { [unowned self] () -> Void in
            self.engine.requestViewControllerWithCompletionHandler { viewController in
                self.viewBtn.enabled = viewController != nil ? true : false
            }
        }

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // =========================================================================
    // MARK: - Actions
    
    func viewBtnTapped(sender: AnyObject) {

        // close
        if childViewControllers.count > 0 {
            let childViewController = childViewControllers.first!
            childViewController.willMoveToParentViewController(nil)
            childViewController.view.removeFromSuperview()
            childViewController.removeFromParentViewController()
            
            viewBtn.title = "ShowAUVC"
            return
        }

        // open
        engine.requestViewControllerWithCompletionHandler { [weak self] viewController in
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
