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
                kItemKeyTitle: "Map Customizations",
                kItemKeyDetail: "Flyover can be selected with new map types, and Traffic, Scale and Compass can be shown.",
                kItemKeyClassPrefix: "MapCustomizations"
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
                kItemKeyTitle: "Content Blockers",
                kItemKeyDetail: "Example for Content Blocker Extension.",
                kItemKeyClassPrefix: "ContentBlocker"
            ],
            [
                kItemKeyTitle: "Attributes of New Filters",
                kItemKeyDetail: "Attributes viewer for new filters of CIFilter.",
                kItemKeyClassPrefix: "Filters"
            ],
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

