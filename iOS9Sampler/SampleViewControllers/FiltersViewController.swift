//
//  FiltersViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 2015/06/19.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class FiltersViewController: UITableViewController {

    private var items: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        items = Filter.names(9, category: kCICategoryBuiltIn)
        print("num:\(items.count)\n")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.destinationViewController.isKindOfClass(FilterDetailViewController) {
            guard let detailCtr = segue.destinationViewController as? FilterDetailViewController else {fatalError()}
            guard let indexPath = tableView.indexPathForSelectedRow else {fatalError()}
        
            let item = items[indexPath.row]
            detailCtr.filterName = item
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
        
        guard let filter = CIFilter(name: name) else {fatalError()}
        cell.detailTextLabel?.text = filter.categoriesDescription()

        return cell
    }
    
    // =========================================================================
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
}
