//
//  SafariViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 9/13/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit
import SafariServices


class SafariViewController: UIViewController, SFSafariViewControllerDelegate {

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

    
    // =========================================================================
    // MARK: - SFSafariViewControllerDelegate
    
    func safariViewController(controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        print(__FUNCTION__+"\n")
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        print(__FUNCTION__+"\n")
    }
    
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func safariBtnTapped() {
        
        let url = NSURL(string: "https://github.com/shu223/")!
        let safariVC = SFSafariViewController(URL: url)
        
        self.presentViewController(
            safariVC,
            animated: true,
            completion: nil)
        
        safariVC.delegate = self
    }
}
