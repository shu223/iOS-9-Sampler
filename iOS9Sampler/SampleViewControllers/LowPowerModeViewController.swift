//
//  LowPowerModeViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 9/9/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class LowPowerModeViewController: UIViewController {
    
    @IBOutlet weak fileprivate var stateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateStateLabel()
        
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name.NSProcessInfoPowerStateDidChange,
            object: nil,
            queue: nil) { [unowned self] (notification: Notification) -> Void in
                
                // A NSProcessInfo object can be retrieved from `object` property.
                let processInfo = notification.object as! ProcessInfo

                DispatchQueue.main.async(execute: {
                    
                    let alert = UIAlertController(
                        title: "Power State has been changed.",
                        message: "Current \"Low Power Mode\" setting: \(processInfo.isLowPowerModeEnabled)",
                        preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(
                        title: "OK",
                        style: UIAlertAction.Style.cancel,
                        handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    
                    self.updateStateLabel()
                })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func updateStateLabel() {
        stateLabel.text = "lowPowerModeEnabled: \(ProcessInfo().isLowPowerModeEnabled)"
    }
}
