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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func safariBtnTapped(_ sender: UIButton) {
        
        let url = URL(string: "https://mobile.twitter.com/shu223")!
        UIApplication.shared.openURL(url)
    }
}
