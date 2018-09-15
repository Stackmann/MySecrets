//
//  IdCardViewController.swift
//  MySecrets
//
//  Created by Eric on 1/8/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import UIKit

class IdCardViewController: UIViewController {

    var chosenRecordIndex: Int = -1

    
    @IBOutlet weak var descriptionValue: UILabel!
    @IBOutlet weak var firstNameValue: UILabel!
    @IBOutlet weak var lastNameValue: UILabel!
    @IBOutlet weak var middleNameValue: UILabel!
    @IBOutlet weak var birthdayValue: UILabel!
    @IBOutlet weak var receivedDateValue: UILabel!
    @IBOutlet weak var snValue: UILabel!
    @IBOutlet weak var numberValue: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var middleNameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var receivedDateLabel: UILabel!
    @IBOutlet weak var snLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(deleteReturnToMainList), name: NSNotification.Name(rawValue: "deleteCurrentRecordEvent"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureController()
    }

    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.closeActivityController), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openactivity), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let chosenNC = segue.destination as? UINavigationController {
            if let chosenVC = chosenNC.topViewController as? IdCardEditTableViewController {
                chosenVC.chosenRecordIndex = chosenRecordIndex
            }
        }
    }

    func configureController() {
        if chosenRecordIndex >= 0, Secrets.share.list.indices.contains(chosenRecordIndex)  {
            let chosenRecord = Secrets.share.list[chosenRecordIndex]
            
            descriptionValue.text = chosenRecord.describe
            descriptionValue.textColor = UIColor.black
            if let pattern = Patterns.share.list[chosenRecord.idPattern] {
                let labels = [firstNameLabel, lastNameLabel, middleNameLabel, birthdayLabel, receivedDateLabel, snLabel, numberLabel]
                var count = 0
                for patternField in pattern.fields {
                    labels[count]?.text = pattern.localizedFields[patternField]
                    count += 1
                }
            }
            if let firstNameStr = chosenRecord.stringFields["FirstName"] {
                firstNameValue.textAlignment = NSTextAlignment.left
                firstNameValue.text = firstNameStr
                firstNameValue.textColor = UIColor.yellow
            } else {
                firstNameValue.text = ""
            }
            if let lastNameStr = chosenRecord.stringFields["LastName"] {
                lastNameValue.textAlignment = NSTextAlignment.left
                lastNameValue.text = lastNameStr
                lastNameValue.textColor = UIColor.yellow
            } else {
                lastNameValue.text = ""
            }
            if let middleNameStr = chosenRecord.stringFields["MiddleName"] {
                middleNameValue.textAlignment = NSTextAlignment.left
                middleNameValue.text = middleNameStr
                middleNameValue.textColor = UIColor.yellow
            } else {
                middleNameValue.text = ""
            }

            if let BirthdayDateStr = chosenRecord.dateFields["BirthdayDate"] {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                birthdayValue.textAlignment = NSTextAlignment.left
                birthdayValue.text = formatter.string(from: BirthdayDateStr)
                birthdayValue.textColor = UIColor.yellow
            } else {
                birthdayValue.text = ""
            }

            if let ReceivedDateStr = chosenRecord.dateFields["ReceivedDate"] {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                receivedDateValue.textAlignment = NSTextAlignment.left
                receivedDateValue.text = formatter.string(from: ReceivedDateStr)
                receivedDateValue.textColor = UIColor.yellow
            } else {
                receivedDateValue.text = ""
            }

            if let snStr = chosenRecord.stringFields["SN"] {
                snValue.textAlignment = NSTextAlignment.left
                snValue.text = snStr
                snValue.textColor = UIColor.yellow
            } else {
                snValue.text = ""
            }

            if let numberStr = chosenRecord.decimalFields["Number"] {
                numberValue.textAlignment = NSTextAlignment.left
                numberValue.text = "\(numberStr)"
                numberValue.textColor = UIColor.yellow
            } else {
                numberValue.text = ""
            }
        }
    }
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showIdEditController", sender: nil)
    }

    @objc private func deleteReturnToMainList() {
        navigationController?.popToRootViewController(animated: true)
    }

    @objc private func closeActivityController()  {
        Secrets.share.dataAvailable = false
    }
    
    @objc private func openactivity()  {
        if !Secrets.share.dataAvailable {
            performSegue(withIdentifier: "enterPwd", sender: nil)
        }
    }

}
