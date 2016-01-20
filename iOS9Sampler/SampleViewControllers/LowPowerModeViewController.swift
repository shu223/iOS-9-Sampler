//
//  LowPowerModeViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 9/9/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class LowPowerModeViewController: UIViewController {

    
    @IBOutlet weak private var stateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.updateStateLabel()
        
        
        NSNotificationCenter.defaultCenter().addObserverForName(
            NSProcessInfoPowerStateDidChangeNotification,
            object: nil,
            queue: nil) { (notification: NSNotification) -> Void in
                
                // A NSProcessInfo object can be retrieved from `object` property.
                let processInfo = notification.object as! NSProcessInfo

                dispatch_async(dispatch_get_main_queue(), {
                    
                    let alert = UIAlertController(
                        title: "Power State has been changed.",
                        message: "Current \"Low Power Mode\" setting: \(processInfo.lowPowerModeEnabled)",
                        preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(
                        title: "OK",
                        style: UIAlertActionStyle.Cancel,
                        handler: nil)
                    alert.addAction(okAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    self.updateStateLabel()
                })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    private func updateStateLabel() {
        
        stateLabel.text = "lowPowerModeEnabled: \(NSProcessInfo().lowPowerModeEnabled)"
    }
}
