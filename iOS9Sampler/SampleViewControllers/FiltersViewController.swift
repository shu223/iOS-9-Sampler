//
//  FiltersViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 2015/06/19.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class FiltersViewController: UITableViewController {

    
    var items: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        items = FilterHelper.filterNamesFor_iOS9(kCICategoryBuiltIn)
        print("num:\(items.count)\n")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.destinationViewController.isKindOfClass(FilterDetailViewController) {
            
            let detailCtr = segue.destinationViewController as! FilterDetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            let item = items![indexPath!.row]
            detailCtr.filterName = item
            
            tableView.deselectRowAtIndexPath(indexPath!, animated: true)
        }
    }
    

    // =========================================================================
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let name = items[indexPath.row]
        cell.textLabel?.text = name
        
        let filter = CIFilter(name: name)!
        cell.detailTextLabel?.text = filter.categoriesStringForFilter()

        return cell
    }
    
    
    // =========================================================================
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
