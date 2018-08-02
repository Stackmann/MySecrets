//
//  CommonViewController.swift
//  MySecrets
//
//  Created by User on 8/1/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {
    var chosenRecordIndex: Int = -1
    
    @IBOutlet weak var descriptionValue: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label1Value: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label2Value: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label3Value: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label4Value: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label5Value: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        configureController()
    }

    // MARK: - add metodes
    
    func configureController() {
        if chosenRecordIndex >= 0, Secrets.share.list.indices.contains(chosenRecordIndex)  {
            let chosenRecord = Secrets.share.list[chosenRecordIndex]
            
            descriptionValue.text = chosenRecord.describe
            descriptionValue.textColor = UIColor.white
            switch chosenRecord.idPattern {
                case "websait" : configureWebsait()
                default : print("Unexpected idPattern")
            }
            
//            if let firstNameStr = chosenRecord.stringFields["FirstName"] {
//                firstNameValue.textAlignment = NSTextAlignment.left
//                firstNameValue.text = firstNameStr
//                //firstNameValue = UIFont(name: "OCRAStd", size: 35)
//                firstNameValue.textColor = UIColor.yellow
//            } else {
//                firstNameValue.text = ""
//            }
//            if let lastNameStr = chosenRecord.stringFields["LastName"] {
//                lastNameValue.textAlignment = NSTextAlignment.left
//                lastNameValue.text = lastNameStr
//                //lastNameValue = UIFont(name: "OCRAStd", size: 35)
//                lastNameValue.textColor = UIColor.yellow
//            } else {
//                lastNameValue.text = ""
//            }
//            if let middleNameStr = chosenRecord.stringFields["MiddleName"] {
//                middleNameValue.textAlignment = NSTextAlignment.left
//                middleNameValue.text = middleNameStr
//                //middleNameValue = UIFont(name: "OCRAStd", size: 35)
//                middleNameValue.textColor = UIColor.yellow
//            } else {
//                middleNameValue.text = ""
//            }
//
//            if let BirthdayDateStr = chosenRecord.dateFields["BirthdayDate"] {
//                let formatter = DateFormatter()
//                formatter.dateFormat = "dd/MM/yyyy"
//                birthdayValue.textAlignment = NSTextAlignment.left
//                birthdayValue.text = formatter.string(from: BirthdayDateStr)
//                //birthdayValue.font = UIFont(name: "OCRAStd", size: 20)
//                birthdayValue.textColor = UIColor.yellow
//            } else {
//                birthdayValue.text = ""
//            }
//
//            if let ReceivedDateStr = chosenRecord.dateFields["ReceivedDate"] {
//                let formatter = DateFormatter()
//                formatter.dateFormat = "dd/MM/yyyy"
//                receivedDateValue.textAlignment = NSTextAlignment.left
//                receivedDateValue.text = formatter.string(from: ReceivedDateStr)
//                //receivedDateValue = UIFont(name: "OCRAStd", size: 20)
//                receivedDateValue.textColor = UIColor.yellow
//            } else {
//                receivedDateValue.text = ""
//            }
//
//            if let snStr = chosenRecord.stringFields["SN"] {
//                snValue.textAlignment = NSTextAlignment.left
//                snValue.text = snStr
//                //snValue.font = UIFont(name: "OCRAStd", size: 20)
//                snValue.textColor = UIColor.yellow
//            } else {
//                snValue.text = ""
//            }
//
//            if let numberStr = chosenRecord.decimalFields["Number"] {
//                numberValue.textAlignment = NSTextAlignment.left
//                numberValue.text = "\(numberStr)"
//                //numberValue.font = UIFont(name: "OCRAStd", size: 20)
//                numberValue.textColor = UIColor.yellow
//            } else {
//                numberValue.text = ""
//            }
        }
    }
    
    func configureWebsait() {
        label1.textColor = UIColor.white
        label1.text = "Login"
        label2.textColor = UIColor.white
        label2.text = "Password"
    }
}
