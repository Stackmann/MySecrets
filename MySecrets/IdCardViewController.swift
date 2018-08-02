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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureController()
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
            if let firstNameStr = chosenRecord.stringFields["FirstName"] {
                firstNameValue.textAlignment = NSTextAlignment.left
                firstNameValue.text = firstNameStr
                //firstNameValue = UIFont(name: "OCRAStd", size: 35)
                firstNameValue.textColor = UIColor.yellow
            } else {
                firstNameValue.text = ""
            }
            if let lastNameStr = chosenRecord.stringFields["LastName"] {
                lastNameValue.textAlignment = NSTextAlignment.left
                lastNameValue.text = lastNameStr
                //lastNameValue = UIFont(name: "OCRAStd", size: 35)
                lastNameValue.textColor = UIColor.yellow
            } else {
                lastNameValue.text = ""
            }
            if let middleNameStr = chosenRecord.stringFields["MiddleName"] {
                middleNameValue.textAlignment = NSTextAlignment.left
                middleNameValue.text = middleNameStr
                //middleNameValue = UIFont(name: "OCRAStd", size: 35)
                middleNameValue.textColor = UIColor.yellow
            } else {
                middleNameValue.text = ""
            }

            if let BirthdayDateStr = chosenRecord.dateFields["BirthdayDate"] {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                birthdayValue.textAlignment = NSTextAlignment.left
                birthdayValue.text = formatter.string(from: BirthdayDateStr)
                //birthdayValue.font = UIFont(name: "OCRAStd", size: 20)
                birthdayValue.textColor = UIColor.yellow
            } else {
                birthdayValue.text = ""
            }

            if let ReceivedDateStr = chosenRecord.dateFields["ReceivedDate"] {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                receivedDateValue.textAlignment = NSTextAlignment.left
                receivedDateValue.text = formatter.string(from: ReceivedDateStr)
                //receivedDateValue = UIFont(name: "OCRAStd", size: 20)
                receivedDateValue.textColor = UIColor.yellow
            } else {
                receivedDateValue.text = ""
            }

            if let snStr = chosenRecord.stringFields["SN"] {
                snValue.textAlignment = NSTextAlignment.left
                snValue.text = snStr
                //snValue.font = UIFont(name: "OCRAStd", size: 20)
                snValue.textColor = UIColor.yellow
            } else {
                snValue.text = ""
            }

            if let numberStr = chosenRecord.decimalFields["Number"] {
                numberValue.textAlignment = NSTextAlignment.left
                numberValue.text = "\(numberStr)"
                //numberValue.font = UIFont(name: "OCRAStd", size: 20)
                numberValue.textColor = UIColor.yellow
            } else {
                numberValue.text = ""
            }
        }
    }
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showIdEditController", sender: nil)
    }

}
