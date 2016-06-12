//
//  FilterDetailViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 2015/06/19.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class FilterDetailViewController: UIViewController {
    
    @IBOutlet private var textView: UITextView!
    var filterName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        title = filterName
        
        let attributes = CIFilter(name: filterName)!.attributes
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
