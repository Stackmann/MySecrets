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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureController() {
        if chosenRecordIndex >= 0, let arraySecrets = Secrets.share.list, arraySecrets.indices.contains(chosenRecordIndex)  {
            let chosenRecord = arraySecrets[chosenRecordIndex]
            
            if let cardNumberStr = chosenRecord.stringFields["NumberCard"] {
                let cardNumberFormatStr = getFormatedCardNumber(with: cardNumberStr)
                cardNumber.textAlignment = NSTextAlignment.left
                cardNumber.text = cardNumberFormatStr
                cardNumber.font = UIFont(name: "OCRAStd", size: 35)
                cardNumber.textColor = UIColor.white
            }
            
            if let cardExpired = chosenRecord.dateFields["Expired"] {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/yy"
                validDate.textAlignment = NSTextAlignment.left
                validDate.text = formatter.string(from: cardExpired)
                validDate.font = UIFont(name: "OCRAStd", size: 20)
                validDate.textColor = UIColor.white
            }
            
            if let holder = chosenRecord.stringFields["Holder"] {
                cardHolder.textAlignment = NSTextAlignment.left
                cardHolder.text = holder
                cardHolder.font = UIFont(name: "OCRAStd", size: 20)
                cardHolder.textColor = UIColor.white
            }
            
            if let bank = chosenRecord.stringFields["Bank"] {
                bankName.textAlignment = NSTextAlignment.left
                bankName.text = bank
                bankName.font = UIFont(name: "OCRAStd", size: 20)
                bankName.textColor = UIColor.white
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
