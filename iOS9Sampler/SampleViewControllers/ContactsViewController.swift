//
//  ContactsViewController.swift
//  iOS9Sampler
//
//  Created by manhattan918 on 2015/9/20.
//  Copyright © 2015 manhattan918. All rights reserved.
//

import UIKit
import Contacts

class ContactsViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var contacts = [CNContact]()
    private var authStatus: CNAuthorizationStatus = .Denied {
        didSet { // switch enabled search bar, depending contacts permission
            searchBar.userInteractionEnabled = authStatus == .Authorized

            if authStatus == .Authorized { // all search
                contacts = fetchContacts("")
                tableView.reloadData()
            }
        }
    }

    private let kCellID = "Cell"


    // =========================================================================
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        checkAuthorization()

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: kCellID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // =========================================================================
    // MARK: - UISearchBarDelegate

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        contacts = fetchContacts(searchText)
        tableView.reloadData()
    }


    // =========================================================================
    //MARK: - UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellID, forIndexPath: indexPath)
        let contact = contacts[indexPath.row]

        // get the full name
        let fullName = CNContactFormatter.stringFromContact(contact, style: .FullName) ?? "NO NAME"
        cell.textLabel?.text = fullName

        return cell
    }


    // =========================================================================
    //MARK: - UITableViewDelegate

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteActionHandler = { (action: UITableViewRowAction, index: NSIndexPath) in
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { [unowned self] (action: UIAlertAction) in
                // set the data to be deleted
                let request = CNSaveRequest()
                let contact = self.contacts[index.row].mutableCopy() as! CNMutableContact
                request.deleteContact(contact)

                do {
                    // save
                    let fullName = CNContactFormatter.stringFromContact(contact, style: .FullName) ?? "NO NAME"
                    let store = CNContactStore()
                    try store.executeSaveRequest(request)
                    NSLog("\(fullName) Deleted")

                    // update table
                    self.contacts.removeAtIndex(index.row)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.deleteRowsAtIndexPaths([index], withRowAnimation: .Fade)
                    })
                } catch let error as NSError {
                    NSLog("Delete error \(error.localizedDescription)")
                }
            })

            let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.Default, handler: { [unowned self] (action: UIAlertAction) in
                self.tableView.editing = false
            })

            // show alert
            self.showAlert(title: "Delete Contact", message: "OK？", actions: [okAction, cancelAction])
        }

        return [UITableViewRowAction(style: .Destructive, title: "Delete", handler: deleteActionHandler)]
    }


    // =========================================================================
    // MARK: - IBAction

    @IBAction func tapped(sender: AnyObject) {
        view.endEditing(true)
    }


    // =========================================================================
    // MARK: - Helpers

    private func checkAuthorization() {
        // get current status
        let status = CNContactStore.authorizationStatusForEntityType(.Contacts)
        authStatus = status

        switch status {
        case .NotDetermined: // case of first access
            CNContactStore().requestAccessForEntityType(.Contacts) { [unowned self] (granted, error) in
                if granted {
                    NSLog("Permission allowed")
                    self.authStatus = .Authorized
                } else {
                    NSLog("Permission denied")
                    self.authStatus = .Denied
                }
            }
        case .Restricted, .Denied:
            NSLog("Unauthorized")

            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            let settingsAction = UIAlertAction(title: "Settings", style: .Default, handler: { (action: UIAlertAction) in
                let url = NSURL(string: UIApplicationOpenSettingsURLString)
                UIApplication.sharedApplication().openURL(url!)
            })
            showAlert(
                title: "Permission Denied",
                message: "You have not permission to access contacts. Please allow the access the Settings screen.",
                actions: [okAction, settingsAction])
        case .Authorized:
            NSLog("Authorized")
        }
    }


    // fetch the contact of matching names
    private func fetchContacts(name: String) -> [CNContact] {
        let store = CNContactStore()

        do {
            let request = CNContactFetchRequest(keysToFetch: [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName)])
            if name.isEmpty { // all search
                request.predicate = nil
            } else {
                request.predicate = CNContact.predicateForContactsMatchingName(name)
            }

            var contacts = [CNContact]()
            try store.enumerateContactsWithFetchRequest(request, usingBlock: { (contact, error) in
                contacts.append(contact)
            })
            
            return contacts
        } catch let error as NSError {
            NSLog("Fetch error \(error.localizedDescription)")
            return []
        }
    }

    private func showAlert(title title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)

        for action in actions {
            alert.addAction(action)
        }

        dispatch_async(dispatch_get_main_queue(), { [unowned self] () in
            self.presentViewController(alert, animated: true, completion: nil)
        })
    }
}
