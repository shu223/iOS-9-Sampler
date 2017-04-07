//
//  SearchAPIsViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 9/12/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class SearchAPIsViewController: UIViewController {

    fileprivate let uniqueIdentifier = "com.shu223.ios9sampler"
    fileprivate let domainIdentifier = "searchapis"
    fileprivate var activity: NSUserActivity!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // NSUserActivity
        let activityType = String(format: "%@.%@", uniqueIdentifier, domainIdentifier)
        activity = NSUserActivity(activityType: activityType)
        activity.title = "iOS-9-Sampler_NSUserActivity"
        activity.keywords = Set<String>(arrayLiteral: "dog", "cat", "pig", "sheep")
        activity.isEligibleForSearch = true
        activity.becomeCurrent()
        
        // Core Spotlight
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
        attributeSet.title = "iOS-9-Sampler_CoreSpotlight"
        attributeSet.contentDescription = "iOS-9-Sampler is a code example collection for new features of iOS 9."
        attributeSet.keywords = ["dog", "cat", "bird", "fish"]
        let image = UIImage(named: "m7")!
        let data = UIImagePNGRepresentation(image)
        attributeSet.thumbnailData = data
        
        let searchableItem = CSSearchableItem(
            uniqueIdentifier: uniqueIdentifier,
            domainIdentifier: domainIdentifier,
            attributeSet: attributeSet)

        CSSearchableIndex.default().indexSearchableItems([searchableItem]) { (error) -> Void in
            if let error = error {
                print("failed with error:\(error)\n")
            }
            else {
                print("Indexed!\n")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
