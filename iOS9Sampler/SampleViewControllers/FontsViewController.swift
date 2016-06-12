//
//  FontsViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 9/17/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class FontsViewController: UITableViewController {

    private var items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let path = NSBundle.mainBundle().pathForResource("AddedFonts9", ofType: "plist") else {fatalError()}
        guard let names = NSArray(contentsOfFile: path) as? [String] else {fatalError()}
        items = names
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // =========================================================================
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let fontName = items[indexPath.row]

        cell.textLabel?.text = fontName
        cell.textLabel?.font = UIFont(name: fontName, size: cell.textLabel!.font.pointSize)
        
        return cell
    }
    
    // =========================================================================
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
