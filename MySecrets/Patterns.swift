//
//  Patterns.swift
//  MySecrets
//
//  Created by Eric on 12/17/17.
//  Copyright © 2017 EricsApp. All rights reserved.
//

import Foundation
import UIKit

class Patterns {
    static let share = Patterns()
    let list: [String: PatternRecord]
    
    init() {
        var listOfPatterns = [String: PatternRecord]()
        guard let avatarCreditCard = UIImage(named: "credit_card_pattern") else { list = listOfPatterns; return }
        guard let avatar2 = UIImage(named: "if_credit-cards_47679") else { list = listOfPatterns; return }
        guard let avatar3 = UIImage(named: "if_lock_49374") else { list = listOfPatterns; return }
        guard let avatar4 = UIImage(named: "if_secure-payment_47685") else { list = listOfPatterns; return }
        guard let avatarIdCard = UIImage(named: "user_id_pattern") else { list = listOfPatterns; return }

        guard let avatarCreditCardData = UIImagePNGRepresentation(avatarCreditCard) else { list = listOfPatterns; return }
        guard let avatarData2 = UIImagePNGRepresentation(avatar2) else { list = listOfPatterns; return }
        guard let avatarData3 = UIImagePNGRepresentation(avatar3) else { list = listOfPatterns; return }
        guard let avatarData4 = UIImagePNGRepresentation(avatar4) else { list = listOfPatterns; return }
        guard let avatarIdCardData = UIImagePNGRepresentation(avatarIdCard) else { list = listOfPatterns; return }

        var patternFields = ["Login": "String",
                             "Password": "String",
                             "URL": "String",
                             "Notes": "String"]
        var newPattern = PatternRecord(describe: "Websait", fields: patternFields, avatar: avatarData2)
        listOfPatterns["websait"] = newPattern

        patternFields = ["Adress": "String",
                         "Login": "String",
                         "Password": "String"]
        newPattern = PatternRecord(describe: "RDP Connection", fields: patternFields, avatar: avatarData3)
        listOfPatterns["rdp"] = newPattern

        patternFields = ["Login": "String",
                         "Password": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Account", fields: patternFields, avatar: avatarData4)
        listOfPatterns["account"] = newPattern

        patternFields = ["Password": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Password", fields: patternFields, avatar: avatarData3)
        listOfPatterns["password"] = newPattern

        patternFields = ["Number": "Int",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Bonus card", fields: patternFields, avatar: avatarData4)
        listOfPatterns["bonuscard"] = newPattern

        patternFields = ["SSID": "String",
                         "Password": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "WiFi", fields: patternFields, avatar: avatarData2)
        listOfPatterns["wifi"] = newPattern

        patternFields = ["Login": "String",
                         "Password": "String",
                         "POP3": "String",
                         "IMAP": "String",
                         "SMTP": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Email", fields: patternFields, avatar: avatarData3)
        listOfPatterns["email"] = newPattern

        patternFields = ["Bank": "String",
                         "NumberCard": "String",
                         "Expired": "Data",
                         "CVV": "Int",
                         "PIN": "Int",
                         "Holder": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Credit Card", fields: patternFields, avatar: avatarCreditCardData)
        listOfPatterns["creditcard"] = newPattern

        patternFields = ["Bank": "String",
                         "BankMFO": "Int",
                         "Account": "Int",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Bank account", fields: patternFields, avatar: avatarData3)
        listOfPatterns["bankaccount"] = newPattern

        patternFields = ["FirstName": "String",
                         "LastName": "String",
                         "MiddleName": "String",
                         "BirthdayDate": "Data",
                         "ReceivedDate": "Data",
                         "SN": "String",
                         "Number": "Int"]
        newPattern = PatternRecord(describe: "Id Card", fields: patternFields, avatar: avatarIdCardData)
        listOfPatterns["id"] = newPattern

        list = listOfPatterns
    }
}
