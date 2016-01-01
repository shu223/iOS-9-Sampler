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


private let uniqueIdentifier = "com.shu223.ios9sampler"
private let domainIdentifier = "searchapis"


class SearchAPIsViewController: UIViewController {

    
    private var activity: NSUserActivity!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // NSUserActivity
        
        let activityType = String(format: "%@.%@", uniqueIdentifier, domainIdentifier)
        activity = NSUserActivity(activityType: activityType)
        activity.title = "iOS-9-Sampler_NSUserActivity"
        activity.keywords = Set<String>(arrayLiteral: "dog", "cat", "pig", "sheep")
        activity.eligibleForSearch = true
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

        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([searchableItem]) { (error) -> Void in
            if error != nil {
                print("failed with error:\(error)\n")
            }
            else {
                print("Indexed!\n")
            }
        }
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

}
