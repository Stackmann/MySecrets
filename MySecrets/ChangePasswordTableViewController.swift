//
//  ChangePasswordTableViewController.swift
//  MySecrets
//
//  Created by User on 1/14/19.
//  Copyright © 2019 Piligrim. All rights reserved.
//

import UIKit

class ChangePasswordTableViewController: UITableViewController {

    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField1: UITextField!
    @IBOutlet weak var newPasswordTextField2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        oldPasswordTextField.placeholder = NSLocalizedString("oldPasswordPlaceHolderText", comment: "Placeholder for old password textfield")
        newPasswordTextField1.placeholder = NSLocalizedString("newPasswordPlaceHolderText1", comment: "Placeholder for new password textfield1")
        newPasswordTextField2.placeholder = NSLocalizedString("newPasswordPlaceHolderText2", comment: "Placeholder for new password textfield2")
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.blue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        if let newTextPassword = newPasswordTextField1.text, newTextPassword.isEmpty {
            let alert = CommonFuncs.getAlert(title: "Error", message: "New password might be not empty")
            self.present(alert, animated: true, completion: nil)
            return
        }
        if let newTextPassword1 = newPasswordTextField1.text, let newTextPassword2 = newPasswordTextField2.text, let oldTextPassword = oldPasswordTextField.text {
                if newTextPassword1 != newTextPassword2 {
                    let alert = CommonFuncs.getAlert(title: "Error", message: "New passwords are not equal")
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            let resultChange = CommonFuncs.changeKeyRealmDB(oldPasswordStr: oldTextPassword, newPasswordStr: newTextPassword1)
            if resultChange.0 {
                let alert = UIAlertController(title: "Information", message: "Success!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.navigationController?.popViewController(animated: true)})
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = CommonFuncs.getAlert(title: "Error", message: resultChange.1)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}
