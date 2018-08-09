//
//  CommonEditTableViewController.swift
//  MySecrets
//
//  Created by User on 8/5/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import UIKit

class CommonEditTableViewController: UITableViewController {
    var chosenRecordIndex = -1
    var currentNum = -1
    var patternToCreate: PatternRecord?

    @IBOutlet weak var barButtonDelete: UIBarButtonItem!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var field1TextField: UITextField!
    @IBOutlet weak var field2TextField: UITextField!
    @IBOutlet weak var field3TextField: UITextField!
    @IBOutlet weak var field4TextField: UITextField!
    @IBOutlet weak var field5TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if chosenRecordIndex >= 0 {
            configure()
        } else {
            currentNum = Secrets.share.lastNum + 1
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.blue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - self metods
    
    func setupUI() {
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        if chosenRecordIndex < 0 {
            barButtonDelete.isEnabled = false
        }
        if let pattern = patternToCreate {
            if let image = UIImage(data: pattern.avatar) {
                avatarImageView.image = image
            }
            // configure labels
            
        }
    }

    func configure() {
        if Secrets.share.list.indices.contains(chosenRecordIndex){
            // Configure the tableView
            let secret = Secrets.share.list[chosenRecordIndex]
            currentNum = secret.num
            if let image = UIImage(data: secret.avatar) {
                avatarImageView.image = image
            }
            descriptionTextField.text = secret.describe
//            firstNameTextField.text = secret.stringFields["FirstName"]
//            lastNameTextField.text = secret.stringFields["LastName"]
//            middleNameTextField.text = secret.stringFields["MiddleName"]
//            let formatter = DateFormatter()
//            formatter.dateFormat = "dd/MM/yyyy"
//            if let birthday = secret.dateFields["BirthdayDate"] {
//                birthdayTextField.text = formatter.string(from: birthday)
//                chosenBirthday = birthday
//                //customDatePicker.date = birthday
//            }
//            if let receivedDate = secret.dateFields["ReceivedDate"] {
//                receivedDateTextField.text = formatter.string(from: receivedDate)
//                chosenReceivedDate = receivedDate
//                //customDatePicker.date = receivedDate
//            }
//            if let number = secret.decimalFields["Number"] {
//                numberTextField.text = "\(number)"
//            }
//            snTextField.text = secret.stringFields["SN"]
        }
    }

}
