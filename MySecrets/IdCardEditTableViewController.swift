//
//  IdCardEditTableViewController.swift
//  MySecrets
//
//  Created by Eric on 1/17/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import UIKit

class IdCardEditTableViewController: UITableViewController, UITextFieldDelegate, AssetsAvatarSelected {
    var chosenRecordIndex = -1
    var chosenBirthday: Date?
    var chosenReceivedDate: Date?
    var currentNum = -1
    var patternKind: PatternRecord?
    private let customDatePicker = DayMonthYearPickerView()
    //private var customAvatarCollection: AvatarCollectionView?

    @IBOutlet weak var avatarImageView: AvatarView! {
        didSet {
            avatarImageView.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAvatarView(recognizer:)))
            avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var middleNameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var receivedDateTextField: UITextField!
    @IBOutlet weak var snTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var barButtonDelete: UIBarButtonItem!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var middleNameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var receivedDateLabel: UILabel!
    @IBOutlet weak var snLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!

    // MARK: - lifecycle viewController metods

    override func viewDidLoad() {
        super.viewDidLoad()
        patternKind = Patterns.share.list[PatternKind.idcard.rawValue]
        setupUI()
        if chosenRecordIndex >= 0 {
            configure()
        } else {
            currentNum = Secrets.share.lastNum + 1
        }
        birthdayTextField.delegate = self
        receivedDateTextField.delegate = self
        snTextField.delegate = self
        snTextField.returnKeyType = .done
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(keyboardWillShow),
//            name: NSNotification.Name.UIKeyboardWillShow,
//            object: nil
//        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.blue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.closeActivityController), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openactivity), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }

    // MARK: - actions

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func deleteAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Confirmation", message: "Remove the record?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancelAction)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            self.deleteRecord()
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        guard let describe = descriptionTextField.text else {
            let alert = CommonFuncs.getAlert(title: "Wrong data!", message: "Fill describe please")
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
        if let firstName = firstNameTextField.text { stringFields["FirstName"] = firstName }
        if let lastName = lastNameTextField.text { stringFields["LastName"] = lastName }
        if let middleName = middleNameTextField.text { stringFields["MiddleName"] = middleName }
        if let sn = snTextField.text { stringFields["SN"] = sn }
        if let number = numberTextField.text, let numberInt = Int(number) { decimalFields["Number"] = numberInt }
        if let birthday = chosenBirthday { dateFields["BirthdayDate"] = birthday }
        if let receivedDate = chosenReceivedDate { dateFields["ReceivedDate"] = receivedDate }

        let currentRecord = RecordPass(describe: describe, stringFields: stringFields, decimalFields: decimalFields, dateFields: dateFields, avatar: avatarData, idPattern: "idcard", num: currentNum)
        
        if chosenRecordIndex >= 0 {
            Secrets.share.list[chosenRecordIndex] = currentRecord
        } else {
            Secrets.share.list.append(currentRecord)
            Secrets.share.lastNum = currentNum
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "editCurrentRecordEvent"), object: nil)
        dismiss(animated: true, completion: nil)

    }
    
    // MARK: - self metods
    
    func setupUI() {
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        numberTextField.keyboardType = .decimalPad
        birthdayTextField.inputView = customDatePicker // datePicker
        birthdayTextField.inputAccessoryView = returnToolBarForBirthday()
        receivedDateTextField.inputView = customDatePicker // datePicker
        receivedDateTextField.inputAccessoryView = returnToolBarForReceivedDate()
        let customAvatarCollection = AvatarCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 216), delegat: self)
        avatarImageView.inputView = customAvatarCollection
        if chosenRecordIndex < 0 {
            barButtonDelete.isEnabled = false
        }
        if let pattern = patternKind {
            if let image = UIImage(data: pattern.avatar) {
                avatarImageView.image = image
            }
            // configure labels
            let labels = [firstNameLabel, lastNameLabel, middleNameLabel, birthdayLabel, receivedDateLabel, snLabel, numberLabel]
            var count = 0
            for patternField in pattern.fields {
                labels[count]?.text = pattern.localizedFields[patternField]
                count += 1
            }
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
            }
            if let receivedDate = secret.dateFields["ReceivedDate"] {
                receivedDateTextField.text = formatter.string(from: receivedDate)
                chosenReceivedDate = receivedDate
            }
            if let number = secret.decimalFields["Number"] {
                numberTextField.text = "\(number)"
            }
            snTextField.text = secret.stringFields["SN"]
        }
    }
    
    private func returnToolBarForBirthday() -> UIToolbar {
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
                                         action: #selector(self.updateChosenBirthday))
        
        doneButton.tintColor = UIColor.blue
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    @objc private func updateChosenBirthday() {
        birthdayTextField.resignFirstResponder()
        
        chosenBirthday = customDatePicker.date
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd/MM/yyyy"
        let chosenBirthdayString = formatter.string(from: customDatePicker.date)
        
        birthdayTextField.text = chosenBirthdayString
    }

    private func returnToolBarForReceivedDate() -> UIToolbar {
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
                                         action: #selector(self.updateChosenReceivedDate))
        
        doneButton.tintColor = UIColor.blue
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    @objc private func updateChosenReceivedDate() {
        receivedDateTextField.resignFirstResponder()
        
        chosenReceivedDate = customDatePicker.date
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd/MM/yyyy"
        let chosenReceivedDateString = formatter.string(from: customDatePicker.date)
        
        receivedDateTextField.text = chosenReceivedDateString
    }

    func deleteRecord() {
        if chosenRecordIndex >= 0 {
            Secrets.share.list.remove(at: chosenRecordIndex)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteCurrentRecordEvent"), object: nil)
        dismiss(animated: true, completion: nil)
    }

    @objc private func closeActivityController()  {
        Secrets.share.dataAvailable = false
    }
    
    @objc private func openactivity()  {
        if !Secrets.share.dataAvailable {
            performSegue(withIdentifier: "enterPwd", sender: nil)
        }
    }

    @objc private func tapAvatarView (recognizer: UITapGestureRecognizer) {
        avatarImageView.becomeFirstResponder()
    }

//    @objc private func keyboardWillShow (_ notification: Notification) {
//        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let customAvatarCollection = AvatarCollectionView(frame: keyboardRectangle, delegat: self)
//            avatarImageView.inputView = customAvatarCollection
//            avatarImageView.reloadInputViews()
//        }
//    }
    
    // MARK: - AssetsAvatarSelected delegate metods
    
    func setNewAvatar(with imageName: String) {
        avatarImageView.image = UIImage(named: imageName)
        avatarImageView.resignFirstResponder()
    }
    
    // MARK: - textfield delegate metods
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case birthdayTextField:
            if let chosenDate = chosenBirthday {
                customDatePicker.date = chosenDate
            }
        case receivedDateTextField:
            if let chosenDate = chosenReceivedDate {
                customDatePicker.date = chosenDate
            }
        default:
            return true
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

protocol AssetsAvatarSelected {
    func setNewAvatar(with imageName: String)
}
