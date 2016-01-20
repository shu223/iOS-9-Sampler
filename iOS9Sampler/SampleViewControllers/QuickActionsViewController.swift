//
//  QuickActionsViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 9/28/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class QuickActionsViewController: UIViewController {

    
    @IBOutlet weak private var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        if traitCollection.forceTouchCapability == UIForceTouchCapability.Available {

            label.text = "Your device supports 3D Touch!"
            label.textColor = UIColor.greenColor()
        }
        else {
            label.text = "Your device does NOT support 3D Touch!"
            label.textColor = UIColor.redColor()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
