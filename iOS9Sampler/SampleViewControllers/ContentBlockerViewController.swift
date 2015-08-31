//
//  ContentBlockerViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 8/31/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//
//  Thanks to:
//  http://www.toyship.org/archives/2182


import UIKit

class ContentBlockerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    
    @IBAction func safariBtnTapped(sender: UIButton) {
        
        let url = NSURL(string: "https://mobile.twitter.com/shu223")!
        UIApplication.sharedApplication().openURL(url)
    }
}
