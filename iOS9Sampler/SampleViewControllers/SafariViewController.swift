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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // =========================================================================
    // MARK: - SFSafariViewControllerDelegate
    
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        print(#function)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        print(#function)
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func safariBtnTapped() {
        
        let url = URL(string: "https://github.com/shu223/")!
        let safariVC = SFSafariViewController(url: url)
        
        present(
            safariVC,
            animated: true,
            completion: nil)
        
        safariVC.delegate = self
    }
}
