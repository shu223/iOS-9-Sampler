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

    @IBOutlet weak fileprivate var tableView: UITableView!
    @IBOutlet weak fileprivate var searchBar: UISearchBar!
    fileprivate var contacts = [CNContact]()
    fileprivate var authStatus: CNAuthorizationStatus = .denied {
        didSet { // switch enabled search bar, depending contacts permission
            searchBar.isUserInteractionEnabled = authStatus == .authorized

            if authStatus == .authorized { // all search
                contacts = fetchContacts("")
                tableView.reloadData()
            }
        }
    }

    fileprivate let kCellID = "Cell"


    // =========================================================================
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        checkAuthorization()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // =========================================================================
    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        contacts = fetchContacts(searchText)
        tableView.reloadData()
    }


    // =========================================================================
    //MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellID, for: indexPath)
        let contact = contacts[indexPath.row]

        // get the full name
        let fullName = CNContactFormatter.string(from: contact, style: .fullName) ?? "NO NAME"
        cell.textLabel?.text = fullName

        return cell
    }


    // =========================================================================
    //MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteActionHandler = { (action: UITableViewRowAction, index: IndexPath) in
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { [unowned self] (action: UIAlertAction) in
                // set the data to be deleted
                let request = CNSaveRequest()
                let contact = self.contacts[index.row].mutableCopy() as! CNMutableContact
                request.delete(contact)

                do {
                    // save
                    let fullName = CNContactFormatter.string(from: contact, style: .fullName) ?? "NO NAME"
                    let store = CNContactStore()
                    try store.execute(request)
                    NSLog("\(fullName) Deleted")

                    // update table
                    self.contacts.remove(at: index.row)
                    DispatchQueue.main.async(execute: {
                        self.tableView.deleteRows(at: [index], with: .fade)
                    })
                } catch let error as NSError {
                    NSLog("Delete error \(error.localizedDescription)")
                }
            })

            let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.default, handler: { [unowned self] (action: UIAlertAction) in
                self.tableView.isEditing = false
            })

            // show alert
            self.showAlert(title: "Delete Contact", message: "OK？", actions: [okAction, cancelAction])
        }

        return [UITableViewRowAction(style: UITableViewRowActionStyle(), title: "Delete", handler: deleteActionHandler)]
    }


    // =========================================================================
    // MARK: - IBAction

    @IBAction func tapped(_ sender: AnyObject) {
        view.endEditing(true)
    }


    // =========================================================================
    // MARK: - Helpers

    fileprivate func checkAuthorization() {
        // get current status
        let status = CNContactStore.authorizationStatus(for: .contacts)
        authStatus = status

        switch status {
        case .notDetermined: // case of first access
            CNContactStore().requestAccess(for: .contacts) { [unowned self] (granted, error) in
                if granted {
                    NSLog("Permission allowed")
                    self.authStatus = .authorized
                } else {
                    NSLog("Permission denied")
                    self.authStatus = .denied
                }
            }
        case .restricted, .denied:
            NSLog("Unauthorized")

            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { (action: UIAlertAction) in
                let url = URL(string: UIApplicationOpenSettingsURLString)
                UIApplication.shared.openURL(url!)
            })
            showAlert(
                title: "Permission Denied",
                message: "You have not permission to access contacts. Please allow the access the Settings screen.",
                actions: [okAction, settingsAction])
        case .authorized:
            NSLog("Authorized")
        }
    }


    // fetch the contact of matching names
    fileprivate func fetchContacts(_ name: String) -> [CNContact] {
        let store = CNContactStore()

        do {
            let request = CNContactFetchRequest(keysToFetch: [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)])
            if name.isEmpty { // all search
                request.predicate = nil
            } else {
                request.predicate = CNContact.predicateForContacts(matchingName: name)
            }

            var contacts = [CNContact]()
            try store.enumerateContacts(with: request, usingBlock: { (contact, error) in
                contacts.append(contact)
            })
            
            return contacts
        } catch let error as NSError {
            NSLog("Fetch error \(error.localizedDescription)")
            return []
        }
    }

    fileprivate func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        for action in actions {
            alert.addAction(action)
        }

        DispatchQueue.main.async(execute: { [unowned self] () in
            self.present(alert, animated: true, completion: nil)
        })
    }
}
