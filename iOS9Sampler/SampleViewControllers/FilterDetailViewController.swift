//
//  FilterDetailViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 2015/06/19.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class FilterDetailViewController: UIViewController {
    
    @IBOutlet fileprivate var textView: UITextView!
    var filterName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let filter = CIFilter(name: filterName) else {fatalError()}
        title = filterName
        
        let attributes = filter.attributes as [String: AnyObject]
        print("attributes:\(attributes)\n")
        
        var attrStr = ""
        for (key, value) in attributes {
            attrStr += String(format: "%@: %@\n\n", key, value.description)
        }
        textView.text = attrStr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
