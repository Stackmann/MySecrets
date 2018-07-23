//
//  IdCardEditTableViewController.swift
//  MySecrets
//
//  Created by Eric on 1/17/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import UIKit

class IdCardEditTableViewController: UITableViewController {
    var chosenRecordIndex = -1
    var chosenBirthday: Date?
    var currentNum = -1
    private let customDatePicker = DayMonthYearPickerView()

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var middleNameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var receivedDateTextField: UITextField!
    @IBOutlet weak var snTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var barButtonDelete: UIBarButtonItem!
    
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
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.blue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        guard let describe = descriptionTextField.text else {
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
//        if let firstName = firstNameTextField.text { stringFields["Bank"] = bankName }
//        if let cardNumber = cardNumberField.text { stringFields["NumberCard"] = cardNumber }
//        if let holder = holderField.text { stringFields["Holder"] = holder }
//        if let notes = notesField.text { stringFields["Notes"] = notes }
//        if let cvv = cvvField.text, let cvvInt = Int(cvv) { decimalFields["CVV"] = cvvInt }
//        if let pin = pinField.text, let pinInt = Int(pin) { decimalFields["PIN"] = pinInt }
//        if let expiredData = chosenExpiredDate { dateFields["Expired"] = expiredData }
//        
//        let currentRecord = RecordPass(describe: describe, stringFields: stringFields, decimalFields: decimalFields, dateFields: dateFields, avatar: avatarData, idPattern: "creditcard", num: currentNum)
//        
//        if chosenRecordIndex >= 0 {
//            Secrets.share.list[chosenRecordIndex] = currentRecord
//        } else {
//            Secrets.share.list.append(currentRecord)
//            Secrets.share.lastNum = currentNum
//        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "editCurrentRecordEvent"), object: nil)
        dismiss(animated: true, completion: nil)

    }

    
    // MARK: - self metods
    
    func setupUI() {
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        numberTextField.keyboardType = .decimalPad
        birthdayTextField.inputView = customDatePicker // datePicker
        birthdayTextField.inputAccessoryView = returnToolBar()
        //receivedDateTextField.inputView = customDatePicker // datePicker
        //receivedDateTextField.inputAccessoryView = returnToolBar()
        if chosenRecordIndex < 0 {
            barButtonDelete.isEnabled = false
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
            firstNameTextField.text = secret.stringFields["FirstName"]
            lastNameTextField.text = secret.stringFields["LastName"]
            middleNameTextField.text = secret.stringFields["MiddleName"]
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            if let birthday = secret.dateFields["BirthdayDate"] {
                birthdayTextField.text = formatter.string(from: birthday)
                chosenBirthday = birthday
                customDatePicker.date = birthday
            }
            if let number = secret.decimalFields["Number"] {
                numberTextField.text = "\(number)"
            }
            snTextField.text = secret.stringFields["SN"]
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
        
        doneButton.tintColor = UIColor.blue
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    @objc private func updateChosenDate() {
        birthdayTextField.resignFirstResponder()
        
        chosenBirthday = customDatePicker.date
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd/MM/yyyy"
        let chosenBirthdayString = formatter.string(from: customDatePicker.date)
        
        birthdayTextField.text = chosenBirthdayString
    }

}
