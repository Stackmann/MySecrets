//
//  OptionsTableViewController.swift
//  MySecrets
//
//  Created by Eric on 12/1/17.
//  Copyright © 2017 EricsApp. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var returnButton: UIBarButtonItem!
    @IBOutlet weak var changePasswordMenuItemLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.blue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.title = NSLocalizedString("SettingsScreenTitle", comment: "Title VC settings")
        returnButton.title = NSLocalizedString("SettingsReturnButtonTitle", comment: "Title of return button in settings")
        changePasswordMenuItemLabel.text = NSLocalizedString("SettingsChangePasswordMenuItemTitle", comment: "Title of change password menu item in settings")
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0, indexPath.row == 0 {
            let alert = UIAlertController(title: NSLocalizedString("ConfirmationAlertTitle", comment: "Title confirmation alert"), message: NSLocalizedString("ChangePwdConfirmation", comment: "Text confirmation about change password"), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(cancelAction)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { [unowned self] action in
                self.performToEnterPasswd()
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return NSLocalizedString("GeneralSettingsHeaderSection", comment: "Header section tableview where general settings")
        } else {return ""}

    }
    
    // MARK: - Table view actions
    @IBAction func cancelSetting(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    func performToEnterPasswd() {
        performSegue(withIdentifier: "changePwd", sender: nil)
    }
}
