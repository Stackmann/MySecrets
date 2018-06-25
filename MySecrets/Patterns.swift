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
        guard let avatarCreditCard = UIImage(named: "credit-cards64x64") else { list = listOfPatterns; return }
        guard let avatarWWW = UIImage(named: "world64x64") else { list = listOfPatterns; return }
        guard let avatarEmail = UIImage(named: "email64x64") else { list = listOfPatterns; return }
        guard let avatarWiFi = UIImage(named: "wireless64x64") else { list = listOfPatterns; return }
        guard let avatarPassword = UIImage(named: "key64") else { list = listOfPatterns; return }
        guard let avatarRDP = UIImage(named: "rdp64x64") else { list = listOfPatterns; return }
        guard let avatarAccount = UIImage(named: "user64x64") else { list = listOfPatterns; return }
        guard let avatar3 = UIImage(named: "bank64") else { list = listOfPatterns; return }
        guard let avatarBonusCard = UIImage(named: "shopping-basket64x64") else { list = listOfPatterns; return }
        guard let avatarIdCard = UIImage(named: "idcard64x64") else { list = listOfPatterns; return }

        guard let avatarCreditCardData = UIImagePNGRepresentation(avatarCreditCard) else { list = listOfPatterns; return }
        guard let avatarWWWData = UIImagePNGRepresentation(avatarWWW) else { list = listOfPatterns; return }
        guard let avatarEmailData = UIImagePNGRepresentation(avatarEmail) else { list = listOfPatterns; return }
        guard let avatarWiFiData = UIImagePNGRepresentation(avatarWiFi) else { list = listOfPatterns; return }
        guard let avatarPasswordData = UIImagePNGRepresentation(avatarPassword) else { list = listOfPatterns; return }
        guard let avatarRDPData = UIImagePNGRepresentation(avatarRDP) else { list = listOfPatterns; return }
        guard let avatarAccountData = UIImagePNGRepresentation(avatarAccount) else { list = listOfPatterns; return }
        guard let avatarData3 = UIImagePNGRepresentation(avatar3) else { list = listOfPatterns; return }
        guard let avatarBonusCardData = UIImagePNGRepresentation(avatarBonusCard) else { list = listOfPatterns; return }
        guard let avatarIdCardData = UIImagePNGRepresentation(avatarIdCard) else { list = listOfPatterns; return }

        var patternFields = ["Login": "String",
                             "Password": "String",
                             "URL": "String",
                             "Notes": "String"]
        var newPattern = PatternRecord(describe: "Websait", fields: patternFields, avatar: avatarWWWData, kind: PatternKind.websait)
        listOfPatterns[PatternKind.websait.rawValue] = newPattern

        patternFields = ["Adress": "String",
                         "Login": "String",
                         "Password": "String"]
        newPattern = PatternRecord(describe: "RDP", fields: patternFields, avatar: avatarRDPData, kind: PatternKind.rdp)
        listOfPatterns[PatternKind.rdp.rawValue] = newPattern

        patternFields = ["Login": "String",
                         "Password": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Account", fields: patternFields, avatar: avatarAccountData, kind: PatternKind.account)
        listOfPatterns[PatternKind.account.rawValue] = newPattern

        patternFields = ["Password": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Password", fields: patternFields, avatar: avatarPasswordData, kind: PatternKind.password)
        listOfPatterns[PatternKind.password.rawValue] = newPattern

        patternFields = ["Number": "Int",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Bonus card", fields: patternFields, avatar: avatarBonusCardData, kind: PatternKind.bonuscard)
        listOfPatterns[PatternKind.bonuscard.rawValue] = newPattern

        patternFields = ["SSID": "String",
                         "Password": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "WiFi", fields: patternFields, avatar: avatarWiFiData, kind: PatternKind.wifi)
        listOfPatterns[PatternKind.wifi.rawValue] = newPattern

        patternFields = ["Login": "String",
                         "Password": "String",
                         "POP3": "String",
                         "IMAP": "String",
                         "SMTP": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Email", fields: patternFields, avatar: avatarEmailData, kind: PatternKind.email)
        listOfPatterns[PatternKind.email.rawValue] = newPattern

        patternFields = ["Bank": "String",
                         "NumberCard": "String",
                         "Expired": "Data",
                         "CVV": "Int",
                         "PIN": "Int",
                         "Holder": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Credit Card", fields: patternFields, avatar: avatarCreditCardData, kind: PatternKind.creditcard)
        listOfPatterns[PatternKind.creditcard.rawValue] = newPattern

        patternFields = ["Bank": "String",
                         "BankMFO": "Int",
                         "Account": "Int",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Bank acc.", fields: patternFields, avatar: avatarData3, kind: PatternKind.bankaccount)
        listOfPatterns[PatternKind.bankaccount.rawValue] = newPattern

        patternFields = ["FirstName": "String",
                         "LastName": "String",
                         "MiddleName": "String",
                         "BirthdayDate": "Data",
                         "ReceivedDate": "Data",
                         "SN": "String",
                         "Number": "Int"]
        newPattern = PatternRecord(describe: "Id Card", fields: patternFields, avatar: avatarIdCardData, kind: PatternKind.idcard)
        listOfPatterns[PatternKind.idcard.rawValue] = newPattern

        list = listOfPatterns
    }
}

