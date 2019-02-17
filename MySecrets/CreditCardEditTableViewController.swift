//
//  SecretEditTableViewController.swift
//  MySecrets
//
//  Created by Eric on 12/20/17.
//  Copyright © 2017 Piligrim. All rights reserved.
//

import UIKit

class CreditCardEditTableViewController: UITableViewController, AssetsAvatarSelected {
    var chosenRecordIndex = -1
    var chosenExpiredDate: Date?
    var currentNum = -1
    var patternKind: PatternRecord?
    private let expiryDatePicker = MonthYearPickerView()

    @IBOutlet weak var avatarImageView: AvatarView! {
        didSet {
            avatarImageView.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAvatarView(recognizer:)))
            avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var bankTextField: UITextField!
    @IBOutlet weak var cardNumberField: UITextField!
    @IBOutlet weak var expiredField: UITextField!
    @IBOutlet weak var cvvField: UITextField!
    @IBOutlet weak var pinField: UITextField!
    @IBOutlet weak var holderField: UITextField!
    @IBOutlet weak var notesField: UITextField!
    @IBOutlet weak var barButtonDelete: UIBarButtonItem!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardExpiredLabel: UILabel!
    @IBOutlet weak var cvvLabel: UILabel!
    @IBOutlet weak var pinCodeLabel: UILabel!
    @IBOutlet weak var holderLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    // MARK: lifecycle metods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        patternKind = Patterns.share.list[PatternKind.creditcard.rawValue]
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

    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.closeActivityController), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openactivity), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
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


    // MARK: - Actions
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: NSLocalizedString("ConfirmationAlertTitle", comment: "Title confirmation alert"), message: NSLocalizedString("RemoveTheRecord", comment: "Text confirmation about remove the record"), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancelAction)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            self.deleteRecord()
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)

    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        guard let describe = descriptionField.text, !describe.isEmpty else {
            let alert = CommonFuncs.getAlert(title: NSLocalizedString("WrongDataAlertTitle", comment: "Title wrong data alert"), message: NSLocalizedString("DescribeIsNotFilled", comment: "Text message about describe that not filled"))
            present(alert, animated: true, completion: nil)
            return
        }
        var stringFields = [String: String]()
        var decimalFields = [String: Int]()
        var dateFields = [String: Date]()
        
        guard let avatarData = UIImagePNGRepresentation(avatarImageView.image!) else {
            let alert = CommonFuncs.getAlert(title: NSLocalizedString("SystemErrorAlertTitle", comment: "Title system error alert"), message: NSLocalizedString("CanNotGetImageOfRecord", comment: "Text message about inability to find image of record"))
            present(alert, animated: true, completion: nil)
            return
        }
        if let bankName = bankTextField.text { stringFields["Bank"] = bankName }
        if let cardNumber = cardNumberField.text { stringFields["NumberCard"] = cardNumber }
        if let holder = holderField.text { stringFields["Holder"] = holder }
        if let notes = notesField.text { stringFields["Notes"] = notes }
        if let cvv = cvvField.text, let cvvInt = Int(cvv) { decimalFields["CVV"] = cvvInt } else {
            guard let localizedField = patternKind?.localizedFields["CVV"] else { return }
            let alertTitle = NSLocalizedString("WrongDataAlertTitle", comment: "Title wrong data alert")
            let alertMessage1 = NSLocalizedString("WrongInputDataFieldMessage", comment: "Wrong input data field message")
            let alertMessage2 = NSLocalizedString("RecommendationUsingDigitsMessage", comment: "Recommendation message about using digits")
            
            let alert = CommonFuncs.getAlert(title: alertTitle, message: alertMessage1 + localizedField + alertMessage2)
            present(alert, animated: true, completion: nil)
            return
        }
        if let pin = pinField.text, let pinInt = Int(pin) { decimalFields["PIN"] = pinInt } else {
            guard let localizedField = patternKind?.localizedFields["PIN"] else { return }
            let alertTitle = NSLocalizedString("WrongDataAlertTitle", comment: "Title wrong data alert")
            let alertMessage1 = NSLocalizedString("WrongInputDataFieldMessage", comment: "Wrong input data field message")
            let alertMessage2 = NSLocalizedString("RecommendationUsingDigitsMessage", comment: "Recommendation message about using digits")
            
            let alert = CommonFuncs.getAlert(title: alertTitle, message: alertMessage1 + localizedField + alertMessage2)
            present(alert, animated: true, completion: nil)
            return
        }
        if let expiredData = chosenExpiredDate { dateFields["Expired"] = expiredData }

        let currentRecord = RecordPass(describe: describe, stringFields: stringFields, decimalFields: decimalFields, dateFields: dateFields, avatar: avatarData, idPattern: "creditcard", num: currentNum)

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
        cardNumberField.keyboardType = .decimalPad
        expiredField.inputView = expiryDatePicker // datePicker
        expiredField.inputAccessoryView = returnToolBar()
        cvvField.keyboardType = .decimalPad
        pinField.keyboardType = .decimalPad
        let customAvatarCollection = AvatarCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 216), delegat: self)
        avatarImageView.inputView = customAvatarCollection

        let textFields = [descriptionField, bankTextField, holderField, notesField]
        for curTextField in textFields {
            curTextField?.autocapitalizationType = UITextAutocapitalizationType.sentences
        }

        if chosenRecordIndex < 0 {
            barButtonDelete.isEnabled = false
        }
        if let pattern = patternKind {
            if let image = UIImage(data: pattern.avatar) {
                avatarImageView.image = image
            }
            // configure labels
            let labels = [bankLabel, cardNumberLabel, cardExpiredLabel, cvvLabel, pinCodeLabel, holderLabel, notesLabel]
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
        let doneButton = UIBarButtonItem(title: NSLocalizedString("ApplyButtonTitle", comment: "Title button Apple"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(self.updateChosenDate))
        
        doneButton.tintColor = UIColor.blue
        
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

    // MARK: - AssetsAvatarSelected delegate metods
    
    func setNewAvatar(with imageName: String) {
        avatarImageView.image = UIImage(named: imageName)
        avatarImageView.resignFirstResponder()
    }

}
