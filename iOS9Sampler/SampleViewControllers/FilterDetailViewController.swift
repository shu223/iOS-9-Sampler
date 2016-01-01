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
        
        self.title = filterName
        
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
