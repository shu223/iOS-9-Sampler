//
//  FiltersViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 2015/06/19.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class FiltersViewController: UITableViewController {

    fileprivate var items: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        items = Filter.names(9, category: kCICategoryBuiltIn)
        print("num:\(items.count)\n")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.destination.isKind(of: FilterDetailViewController.self) {
            guard let detailCtr = segue.destination as? FilterDetailViewController else {fatalError()}
            guard let indexPath = tableView.indexPathForSelectedRow else {fatalError()}
        
            let item = items[indexPath.row]
            detailCtr.filterName = item
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    // =========================================================================
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let name = items[indexPath.row]
        cell.textLabel?.text = name
        
        guard let filter = CIFilter(name: name) else {fatalError()}
        cell.detailTextLabel?.text = filter.categoriesDescription()

        return cell
    }
    
    // =========================================================================
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
