//
//  RootViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 2015/06/10.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit


let kItemKeyTitle       = "title"
let kItemKeyDetail      = "detail"
let kItemKeyClassPrefix = "prefix"


class RootViewController: UITableViewController {
    
    
    var items: [Dictionary<String, String>]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [
            [
                kItemKeyTitle: "Map Customizations",
                kItemKeyDetail: "Flyover can be selected with new map types, and Traffic, Scale and Compass can be shown.",
                kItemKeyClassPrefix: "MapCustomizations"
            ],
            [
                kItemKeyTitle: "Text Detector",
                kItemKeyDetail: "Text detection using new detector type \"CIDetectorTypeText\".",
                kItemKeyClassPrefix: "TextDetect"
            ],
            [
                kItemKeyTitle: "New Image Filters",
                kItemKeyDetail: "New filters of CIFilter which can be used for Still Images.",
                kItemKeyClassPrefix: "StillImageFilters",
            ],
            [
                kItemKeyTitle: "Audio Unit Component Manager",
                kItemKeyDetail: "Retrieve available audio units using AudioUnitComponentManager and apply them to a sound. If there are some Audio Unit Extensions, they will be also shown.",
                kItemKeyClassPrefix: "AudioUnitComponentManager",
            ],
            [
                kItemKeyTitle: "Speech Voices",
                kItemKeyDetail: "Example for new properties which are added to AVSpeechSynthesisVoice such as language, name, quality...",
                kItemKeyClassPrefix: "Speech",
            ],
            [
                kItemKeyTitle: "CASpringAnimation",
                kItemKeyDetail: "Animation example using CASpringAnimation.",
                kItemKeyClassPrefix: "Spring"
            ],
            [
                kItemKeyTitle: "Core Image Transitions",
                kItemKeyDetail: "New transition effects which are added to CITransitionCategory.",
                kItemKeyClassPrefix: "CoreImageTransitions"
            ],
            [
                kItemKeyTitle: "UIStackView",
                kItemKeyDetail: "Auto Layout example using UIStackView.",
                kItemKeyClassPrefix: "StackView"
            ],
            [
                kItemKeyTitle: "Selfies & Screenshots",
                kItemKeyDetail: "Fetch photos filtered with new subtypes \"SelfPortraits\" and \"Screenshot\" which are added to Photos framework.",
                kItemKeyClassPrefix: "Photos"
            ],
            [
                kItemKeyTitle: "String Transform",
                kItemKeyDetail: "String transliteration examples using new APIs of Foundation framework.",
                kItemKeyClassPrefix: "StringTransform"
            ],
            [
                kItemKeyTitle: "Search APIs",
                kItemKeyDetail: "Example for Search APIs using NSUserActivity and Core Spotlight.",
                kItemKeyClassPrefix: "SearchAPIs"
            ],
            [
                kItemKeyTitle: "Content Blockers",
                kItemKeyDetail: "Example for Content Blocker Extension.",
                kItemKeyClassPrefix: "ContentBlocker"
            ],
            [
                kItemKeyTitle: "SFSafariViewController",
                kItemKeyDetail: "Open web pages with SFSafariViewController.",
                kItemKeyClassPrefix: "Safari"
            ],
            [
                kItemKeyTitle: "Attributes of New Filters",
                kItemKeyDetail: "Extract new filters of CIFilter using \"kCIAttributeFilterAvailable_iOS\".",
                kItemKeyClassPrefix: "Filters"
            ],
            [
                kItemKeyTitle: "Low Power Mode",
                kItemKeyDetail: "Detect changes of \"Low Power Mode\" setting.",
                kItemKeyClassPrefix: "LowPowerMode"
            ],
            [
                kItemKeyTitle: "New Fonts",
                kItemKeyDetail: "Gallery of new fonts.",
                kItemKeyClassPrefix: "Fonts"
            ],
            [
                kItemKeyTitle: "Contacts",
                kItemKeyDetail: "Contacts framework sample.",
                kItemKeyClassPrefix: "Contacts"
            ],
            [
                kItemKeyTitle: "ReplayKit",
                kItemKeyDetail: "ReplayKit framework sample.",
                kItemKeyClassPrefix: "ReplayKit"
            ],
            [
                kItemKeyTitle: "Quick Actions",
                kItemKeyDetail: "Access the shortcut menu on the Home screen using 3D Touch.",
                kItemKeyClassPrefix: "QuickActions"
            ],
            [
                kItemKeyTitle: "Force Touch",
                kItemKeyDetail: "Visualize the forces of touches using new properties of UITouch.",
                kItemKeyClassPrefix: "ForceTouch"
            ],
        ]
    }

    override func viewDidAppear(animated: Bool) {
        // Needed after custome transition
        navigationController?.delegate = nil;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // =========================================================================
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RootViewCell
        
        let item = items[indexPath.row]
        cell.titleLabel!.text  = item[kItemKeyTitle]
        cell.detailLabel!.text = item[kItemKeyDetail]
        
        return cell
    }
    
    
    // =========================================================================
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let item = items[indexPath.row]
        let prefix = item[kItemKeyClassPrefix]
        
        let storyboard = UIStoryboard(name: prefix!, bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        self.navigationController?.pushViewController(controller!, animated: true)
        
        controller!.title = item[kItemKeyTitle]
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

