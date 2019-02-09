//
//  ChangePasswordTableViewController.swift
//  MySecrets
//
//  Created by User on 1/14/19.
//  Copyright © 2019 Piligrim. All rights reserved.
//

import UIKit

class ChangePasswordTableViewController: UITableViewController {

    @IBOutlet weak var newPasswordTextField1: UITextField!
    @IBOutlet weak var newPasswordTextField2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        newPasswordTextField1.placeholder = NSLocalizedString("newPasswordPlaceHolderText1", comment: "Placeholder for new password textfield1")
        newPasswordTextField2.placeholder = NSLocalizedString("newPasswordPlaceHolderText2", comment: "Placeholder for new password textfield2")
        Secrets.share.dataAvailable = false
        performSegue(withIdentifier: "enterPwd", sender: nil)
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return NSLocalizedString("ChangePwdHeaderSection", comment: "Header section tableview where input new password")
        } else {return ""}
    }

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        if let newTextPassword = newPasswordTextField1.text, newTextPassword.isEmpty {
            let titleAlert = NSLocalizedString("UserErrorAlertTitle", comment: "Title user's error alert")
            let textAlert = NSLocalizedString("NewPwdIsEmptyErrorText", comment: "Text user's error empty new password")
            let alert = CommonFuncs.getAlert(title: titleAlert, message: textAlert)
            self.present(alert, animated: true, completion: nil)
            return
        }
        if let newTextPassword1 = newPasswordTextField1.text, let newTextPassword2 = newPasswordTextField2.text {
            if newTextPassword1 != newTextPassword2 {
                let titleAlert = NSLocalizedString("UserErrorAlertTitle", comment: "Title user's error alert")
                let textAlert = NSLocalizedString("NewPwdIsEqualErrorText", comment: "Text user's error new passwords are not equal")
                let alert = CommonFuncs.getAlert(title: titleAlert, message: textAlert)
                self.present(alert, animated: true, completion: nil)
                return
            }
            let isContainCorrectCharacters = newTextPassword1.isContainCorrectCharactersForRealmPassword
            if !isContainCorrectCharacters.0 {
                let titleAlert = NSLocalizedString("UserErrorAlertTitle", comment: "Title user's error alert")
                let textAlert = NSLocalizedString("PwdTextContainIncorrectCharacter", comment: "Text user's error incorrect character")
                let alert = CommonFuncs.getAlert(title: titleAlert, message: textAlert + "\(isContainCorrectCharacters.1 + 1)!")
                self.present(alert, animated: true, completion: nil)
                return
            }

            let resultChange = CommonFuncs.changeKeyRealmDB(newPasswordStr: newTextPassword1)
            if resultChange.0 {
                let titleAlert = NSLocalizedString("UserInformationAlertTitle", comment: "Title user's information alert")
                let textAlert = NSLocalizedString("UserActionSuccessText", comment: "Text user's successful result action")
                let textOKActionAlert = NSLocalizedString("UserOKFeedbackText", comment: "Text user's OK feedback")

                let alert = UIAlertController(title: titleAlert, message: textAlert, preferredStyle: .alert)
                let okAction = UIAlertAction(title: textOKActionAlert, style: .default, handler: {[unowned self] action in self.navigationController?.popViewController(animated: true)})
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                let titleAlert = NSLocalizedString("SystemErrorAlertTitle", comment: "Title system error alert")
                let alert = CommonFuncs.getAlert(title: titleAlert, message: resultChange.1)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}
