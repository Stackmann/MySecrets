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
    var patternKind: PatternRecord?
    var maxRowOfLabelCount = 6
    
    @IBOutlet weak var barButtonDelete: UIBarButtonItem!
    @IBOutlet weak var avatarImageView: UIImageView!
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
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        guard let describe = descriptionTextField.text else {
            let alert = CommonFuncs.getAlert(title: "Wrong data!", message: "Fill describe please")
            present(alert, animated: true, completion: nil)
            return
        }
        var stringFields = [String: String]()
        var decimalFields = [String: Int]()
        let dateFields = [String: Date]()

        guard let avatarData = UIImagePNGRepresentation(avatarImageView.image!) else {
            let alert = CommonFuncs.getAlert(title: "System error!", message: "Can't get image of the record.")
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
                            let alert = CommonFuncs.getAlert(title: "Wrong data!", message: "Invalid field " + localizedField + ". Please, use only digits.")
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
        let alert = UIAlertController(title: "Confirmation", message: "Remove the record?", preferredStyle: .alert)
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

}
