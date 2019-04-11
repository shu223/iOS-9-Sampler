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

    @IBOutlet weak fileprivate var tableView: UITableView!
    fileprivate var viewBtn: UIBarButtonItem!
    
    fileprivate var items = [AVAudioUnitComponent]()

    fileprivate var engine = AudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewBtn = UIBarButtonItem(
            title: "ShowAUVC",
            style: UIBarButtonItem.Style.plain,
            target: self, action: #selector(AudioUnitComponentManagerViewController.viewBtnTapped(_:)))
        navigationItem.setRightBarButton(viewBtn, animated: false)
        viewBtn.isEnabled = false
        
        // extract available effects
        items = AVAudioUnitComponentManager.shared()
            .components(matching: AudioComponent.anyEffectDescription())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        engine.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        engine.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // =========================================================================
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let auComponent: AVAudioUnitComponent?

        if indexPath.row == 0 {
            // no effect
            auComponent = nil
        } else {
            auComponent = items[indexPath.row - 1]
        }
        
        engine.selectEffectWithComponentDescription(auComponent?.audioComponentDescription) { [unowned self] () -> Void in
            self.engine.requestViewControllerWithCompletionHandler { viewController in
                self.viewBtn.isEnabled = viewController != nil ? true : false
            }
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @objc func viewBtnTapped(_ sender: AnyObject) {

        // close
        if children.count > 0 {
            let childViewController = children.first!
            childViewController.willMove(toParent: nil)
            childViewController.view.removeFromSuperview()
            childViewController.removeFromParent()
            
            viewBtn.title = "ShowAUVC"
            return
        }

        // open
        engine.requestViewControllerWithCompletionHandler { [weak self] viewController in
            guard let strongSelf = self else { return }
            guard let viewController = viewController, let view = viewController.view else { return }

            strongSelf.addChild(viewController)
            let parentRect = strongSelf.view.bounds
            view.frame = CGRect(
                x: 0,
                y: parentRect.size.height / 2,
                width: parentRect.size.width,
                height: parentRect.size.height / 2)

            strongSelf.view.addSubview(view)
            viewController.didMove(toParent: self)
            
            strongSelf.viewBtn.title = "CloseAUVC"
        }
    }
}
