//
//  SecretViewController.swift
//  MySecrets
//
//  Created by Eric on 12/22/17.
//  Copyright © 2017 Piligrim. All rights reserved.
//

import UIKit

class CreditCardViewController: UIViewController {

    @IBOutlet weak var recordImageView: UIImageView!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var validDate: UILabel!
    @IBOutlet weak var cardHolder: UILabel!
    @IBOutlet weak var bankName: UILabel!
 
    var chosenRecordIndex: Int!

    // MARK: lifecycle metods

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureController()
        //OCRAStd
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let chosenNC = segue.destination as? UINavigationController {
            if let chosenVC = chosenNC.topViewController as? CreditCardEditTableViewController {
                chosenVC.chosenRecordIndex = chosenRecordIndex
            }
        }
    }

    // MARK: - own metods

    private func getFormatedCardNumber(with cardNumber: String) -> String {
        var formatedCardNumber = ""
        if let _ = Int(cardNumber) {
            var countDigit = 0
            
            for digitStr in cardNumber {
                countDigit += 1
                formatedCardNumber = formatedCardNumber + String(digitStr)
                if countDigit == 4 {
                    formatedCardNumber = formatedCardNumber + " "
                    countDigit = 0
                }
            }
            
        }
        return formatedCardNumber
    }

    func configureController() {
        if chosenRecordIndex >= 0, Secrets.share.list.indices.contains(chosenRecordIndex)  {
            let chosenRecord = Secrets.share.list[chosenRecordIndex]
            
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

    // MARK: - Actions

    @IBAction func editAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showCreditCardEditController", sender: nil)
    }
    


}
