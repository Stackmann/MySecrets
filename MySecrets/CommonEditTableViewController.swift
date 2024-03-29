//
//  CommonEditTableViewController.swift
//  MySecrets
//
//  Created by User on 8/5/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import UIKit

class CommonEditTableViewController: UITableViewController, AssetsAvatarSelected {
    var chosenRecordIndex = -1
    var currentNum = -1
    var patternKind: PatternRecord?
    var maxRowOfLabelCount = 6
    
    @IBOutlet weak var barButtonDelete: UIBarButtonItem!
    @IBOutlet weak var avatarImageView: AvatarView! {
        didSet {
            avatarImageView.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAvatarView(recognizer:)))
            avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var field1TextField: UITextField!
    @IBOutlet weak var field2TextField: UITextField!
    @IBOutlet weak var field3TextField: UITextField!
    @IBOutlet weak var field4TextField: UITextField!
    @IBOutlet weak var field5TextField: UITextField!
    @IBOutlet weak var field6TextField: UITextField!
    @IBOutlet weak var field1Label: UILabel!
    @IBOutlet weak var field2Label: UILabel!
    @IBOutlet weak var field3Label: UILabel!
    @IBOutlet weak var field4Label: UILabel!
    @IBOutlet weak var field5Label: UILabel!
    @IBOutlet weak var field6Label: UILabel!

    // MARK: - lifecycle viewController metods

    override func viewDidLoad() {
        super.viewDidLoad()
        if chosenRecordIndex >= 0 {
            if Secrets.share.list.indices.contains(chosenRecordIndex) {
                let secret = Secrets.share.list[chosenRecordIndex]
                patternKind = Patterns.share.list[secret.idPattern]
                setupUI()
                configure()
            }
        } else {
            setupUI()
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

    // MARK: - actions

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        guard let describe = descriptionTextField.text, !describe.isEmpty else {
            let alert = CommonFuncs.getAlert(title: NSLocalizedString("WrongDataAlertTitle", comment: "Title wrong data alert"), message: NSLocalizedString("DescribeIsNotFilled", comment: "Text message about describe that not filled"))
            present(alert, animated: true, completion: nil)
            return
        }
        var stringFields = [String: String]()
        var decimalFields = [String: Int]()
        let dateFields = [String: Date]()

        guard let avatarData = UIImagePNGRepresentation(avatarImageView.image!) else {
            let alert = CommonFuncs.getAlert(title: NSLocalizedString("SystemErrorAlertTitle", comment: "Title system error alert"), message: NSLocalizedString("CanNotGetImageOfRecord", comment: "Text message about inability to find image of record"))
            present(alert, animated: true, completion: nil)
            return
        }
        let textFields = [field1TextField, field2TextField, field3TextField, field4TextField, field5TextField, field6TextField]
        if let pattern = patternKind {
            var count = 0
            for field in pattern.fields {
                if let typeField = pattern.typesOfFields[field], typeField == "Int" {
                    if let valueStr = textFields[count]?.text {
                        if let valueInt = Int(valueStr) { decimalFields[field] = valueInt} else {
                            guard let localizedField = pattern.localizedFields[field] else { return }
                            let alertTitle = NSLocalizedString("WrongDataAlertTitle", comment: "Title wrong data alert")
                            let alertMessage1 = NSLocalizedString("WrongInputDataFieldMessage", comment: "Wrong input data field message")
                            let alertMessage2 = NSLocalizedString("RecommendationUsingDigitsMessage", comment: "Recommendation message about using digits")

                            let alert = CommonFuncs.getAlert(title: alertTitle, message: alertMessage1 + localizedField + alertMessage2)
                            present(alert, animated: true, completion: nil)
                            return
                        }
                    }
                } else { //string
                    if let valueStr = textFields[count]?.text { stringFields[field] = valueStr}
                }
                count += 1
            }
            let currentRecord = RecordPass(describe: describe, stringFields: stringFields, decimalFields: decimalFields, dateFields: dateFields, avatar: avatarData, idPattern: pattern.kind.rawValue, num: currentNum)
            
            if chosenRecordIndex >= 0 {
                Secrets.share.list[chosenRecordIndex] = currentRecord
            } else {
                Secrets.share.list.append(currentRecord)
                Secrets.share.lastNum = currentNum
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "editCurrentRecordEvent"), object: nil)
            dismiss(animated: true, completion: nil)

        }
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
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let pattern = patternKind {
            return pattern.fields.count + 1
        } else {
            return 6
        }
    }

    // MARK: - self metods
    
    func setupUI() {
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        if chosenRecordIndex < 0 {
            barButtonDelete.isEnabled = false
        }
        let customAvatarCollection = AvatarCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 216), delegat: self)
        avatarImageView.inputView = customAvatarCollection
        descriptionTextField.autocapitalizationType = UITextAutocapitalizationType.sentences
        if let pattern = patternKind {
            if let image = UIImage(data: pattern.avatar) {
                avatarImageView.image = image
            }
            // configure labels and textFields
            let labels = [field1Label, field2Label, field3Label, field4Label, field5Label, field6Label]
            let textFields = [field1TextField, field2TextField, field3TextField, field4TextField, field5TextField, field6TextField]
            var count = 0
            for patternField in pattern.fields {
                labels[count]?.text = pattern.localizedFields[patternField]
                if let typeField = pattern.typesOfFields[patternField], typeField == "Int" {
                    textFields[count]?.keyboardType = .decimalPad
                }
                if patternField.contains("Notes") || patternField.contains("Bank") {
                    textFields[count]?.autocapitalizationType = UITextAutocapitalizationType.sentences
                }
                count += 1
            }
        }
    }

    func configure() {
        if Secrets.share.list.indices.contains(chosenRecordIndex){
            // Configure the tableView
            let textFields = [field1TextField, field2TextField, field3TextField, field4TextField, field5TextField, field6TextField]
            let secret = Secrets.share.list[chosenRecordIndex]
            currentNum = secret.num
            if let image = UIImage(data: secret.avatar) {
                avatarImageView.image = image
            }
            descriptionTextField.text = secret.describe
            if let pattern = patternKind {
                var count = 0
                for patternField in pattern.fields {
                    if let typeField = pattern.typesOfFields[patternField] {
                        if typeField == "String" {
                            textFields[count]?.text = secret.stringFields[patternField]
                        } else if let intValue = secret.decimalFields[patternField] {
                            textFields[count]?.text = "\(intValue)"
                    }
                    }
                    count += 1
                }
            }
        }
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
