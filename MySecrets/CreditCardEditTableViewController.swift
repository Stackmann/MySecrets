//
//  SecretEditTableViewController.swift
//  MySecrets
//
//  Created by Eric on 12/20/17.
//  Copyright © 2017 Piligrim. All rights reserved.
//

import UIKit

class CreditCardEditTableViewController: UITableViewController {
    var chosenRecordIndex = -1
    var chosenExpiredDate: Date?
    //    private let datePicker = UIDatePicker()
    private let expiryDatePicker = MonthYearPickerView()
    //    expiryDatePicker.onDateSelected = { (month: Int, year: Int) in
    //    let string = String(format: "%02d/%d", month, year)
    //    NSLog(string) // should show something like 05/2015
    //    }

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var bankTextField: UITextField!
    @IBOutlet weak var cardNumberField: UITextField!
    @IBOutlet weak var expiredField: UITextField!
    @IBOutlet weak var cvvField: UITextField!
    @IBOutlet weak var pinField: UITextField!
    @IBOutlet weak var holderField: UITextField!
    @IBOutlet weak var notesField: UITextField!

    // MARK: lifecycle metods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if chosenRecordIndex >= 0 {
            configure()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.blue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
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


    // MARK: - Actions
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        guard let describe = descriptionField.text else {
            let alert = UIAlertController(title: "Wrong data!", message: "Fill describe please", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        var stringFields = [String: String]()
        var decimalFields = [String: Int]()
        var dateFields = [String: Date]()
        
        guard let avatarData = UIImagePNGRepresentation(avatarImageView.image!) else {
            let alert = CommonFuncs.getAlert(title: "System error!", message: "Can not get image of record.")
            present(alert, animated: true, completion: nil)
            return
        }
        if let bankName = bankTextField.text { stringFields["Bank"] = bankName }
        if let cardNumber = cardNumberField.text { stringFields["NumberCard"] = cardNumber }
        if let holder = holderField.text { stringFields["Holder"] = holder }
        if let notes = notesField.text { stringFields["Notes"] = notes }
        if let cvv = cvvField.text, let cvvInt = Int(cvv) { decimalFields["CVV"] = cvvInt }
        if let pin = pinField.text, let pinInt = Int(pin) { decimalFields["PIN"] = pinInt }
        if let expiredData = chosenExpiredDate { dateFields["Expired"] = expiredData }
        Secrets.share.lastNum += 1
        let currentRecord = RecordPass(describe: describe, stringFields: stringFields, decimalFields: decimalFields, dateFields: dateFields, avatar: avatarData, idPattern: "creditcard", num: Secrets.share.lastNum)

        if chosenRecordIndex >= 0 {
            Secrets.share.list[chosenRecordIndex] = currentRecord
        } else {
            Secrets.share.list.append(currentRecord)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "editCurrentRecordEvent"), object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - self metods
    
    func setupUI() {
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        cardNumberField.keyboardType = .decimalPad
        //datePicker.datePickerMode = .date
        expiredField.inputView = expiryDatePicker // datePicker
        expiredField.inputAccessoryView = returnToolBar()
        cvvField.keyboardType = .decimalPad
        pinField.keyboardType = .decimalPad
    }
    
    
    func configure() {
        if Secrets.share.list.indices.contains(chosenRecordIndex){
            // Configure the tableView
            let secret = Secrets.share.list[chosenRecordIndex]
            if let image = UIImage(data: secret.avatar) {
                avatarImageView.image = image
            }
            descriptionField.text = secret.describe
            bankTextField.text = secret.stringFields["Bank"]
            cardNumberField.text = secret.stringFields["NumberCard"]
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/yy"
            if let expired = secret.dateFields["Expired"] {
                expiredField.text = formatter.string(from: expired)
                chosenExpiredDate = expired
                expiryDatePicker.date = expired
            }
            if let cvv = secret.decimalFields["CVV"] {
                cvvField.text = "\(cvv)"
            }
            if let pin = secret.decimalFields["PIN"] {
                pinField.text = "\(pin)"
            }
            holderField.text = secret.stringFields["Holder"]
            notesField.text = secret.stringFields["Notes"]
        }
    }

    private func returnToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        //        toolBar.sizeToFit()
        toolBar.frame = CGRect(x: toolBar.frame.origin.x,
                               y: toolBar.frame.origin.y,
                               width: toolBar.frame.width,
                               height: 32)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Готово",
                                         style: .plain,
                                         target: self,
                                         action: #selector(self.updateChosenDate))
        
        doneButton.tintColor = UIColor.green
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    @objc private func updateChosenDate() {
        expiredField.resignFirstResponder()
        
        chosenExpiredDate = expiryDatePicker.date
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM/yy"
        let chosenDateString = formatter.string(from: expiryDatePicker.date)

        expiredField.text = chosenDateString
    }

}
