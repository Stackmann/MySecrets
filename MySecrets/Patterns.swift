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
        var localizedFields = [NSLocalizedString("Login", comment: "Login to websait"): "String",
                             NSLocalizedString("Password", comment: "Password to websait"): "String",
                             NSLocalizedString("URL", comment: "URL of websait"): "String",
                             NSLocalizedString("Notes", comment: "Notes about secret"): "String"]
        var newPattern = PatternRecord(describe: "Websait", fields: patternFields, localizedFields: localizedFields, avatar: avatarWWWData, kind: PatternKind.websait)
        listOfPatterns[PatternKind.websait.rawValue] = newPattern

        patternFields = ["Adress": "String",
                         "Login": "String",
                         "Password": "String"]
        localizedFields = [NSLocalizedString("Adress", comment: "Adress of RDP server"): "String",
                         NSLocalizedString("Login", comment: "Login to RDP server"): "String",
                         NSLocalizedString("Password", comment: "Password to RDP server"): "String"]
        newPattern = PatternRecord(describe: "RDP", fields: patternFields, localizedFields: localizedFields, avatar: avatarRDPData, kind: PatternKind.rdp)
        listOfPatterns[PatternKind.rdp.rawValue] = newPattern

        patternFields = ["Login": "String",
                         "Password": "String",
                         "Notes": "String"]
        localizedFields = [NSLocalizedString("Login", comment: "Login of account"): "String",
                         NSLocalizedString("Password", comment: "Password of account"): "String",
                         NSLocalizedString("Notes", comment: "Notes about account"): "String"]
        newPattern = PatternRecord(describe: "Account", fields: patternFields, localizedFields: localizedFields, avatar: avatarAccountData, kind: PatternKind.account)
        listOfPatterns[PatternKind.account.rawValue] = newPattern

        patternFields = ["Password": "String",
                         "Notes": "String"]
        localizedFields = [NSLocalizedString("Password", comment: "Password of secret with pattern Password"): "String",
                         NSLocalizedString("Notes", comment: "Notes of secret with pattern Password"): "String"]
        newPattern = PatternRecord(describe: "Password", fields: patternFields, localizedFields: localizedFields, avatar: avatarPasswordData, kind: PatternKind.password)
        listOfPatterns[PatternKind.password.rawValue] = newPattern

        patternFields = ["Number": "Int",
                         "Notes": "String"]
        localizedFields = [NSLocalizedString("Number", comment: "Number of bonus card"): "Int",
                         NSLocalizedString("Notes", comment: "Notes of bonus card"): "String"]
        newPattern = PatternRecord(describe: "Bonus card", fields: patternFields, localizedFields: localizedFields, avatar: avatarBonusCardData, kind: PatternKind.bonuscard)
        listOfPatterns[PatternKind.bonuscard.rawValue] = newPattern

        patternFields = ["SSID": "String",
                         "Password": "String",
                         "Notes": "String"]
        localizedFields = [NSLocalizedString("SSID", comment: "SSID of WiFi networks"): "String",
                         NSLocalizedString("Password", comment: "Key phrase of WiFi networks"): "String",
                         NSLocalizedString("Notes", comment: "Notes of WiFi networks"): "String"]
        newPattern = PatternRecord(describe: "WiFi", fields: patternFields, localizedFields: localizedFields, avatar: avatarWiFiData, kind: PatternKind.wifi)
        listOfPatterns[PatternKind.wifi.rawValue] = newPattern

        patternFields = ["Login": "String",
                         "Password": "String",
                         "POP3": "String",
                         "IMAP": "String",
                         "SMTP": "String",
                         "Notes": "String"]
        localizedFields = [NSLocalizedString("Login", comment: "Login of email authorization"): "String",
                         NSLocalizedString("Password", comment: "Password of email authorization"): "String",
                         NSLocalizedString("POP3", comment: "POP3 server of email"): "String",
                         NSLocalizedString("IMAP", comment: "IMAP server of email"): "String",
                         NSLocalizedString("SMTP", comment: "SMTP server of email"): "String",
                         NSLocalizedString("Notes", comment: "Notes about email"): "String"]
        newPattern = PatternRecord(describe: "Email", fields: patternFields, localizedFields: localizedFields, avatar: avatarEmailData, kind: PatternKind.email)
        listOfPatterns[PatternKind.email.rawValue] = newPattern

        patternFields = ["Bank": "String",
                         "NumberCard": "String",
                         "Expired": "Data",
                         "CVV": "Int",
                         "PIN": "Int",
                         "Holder": "String",
                         "Notes": "String"]
        localizedFields = [NSLocalizedString("Bank", comment: "Bank of credit card"): "String",
                         NSLocalizedString("NumberCard", comment: "Number of credit card"): "String",
                         NSLocalizedString("Expired", comment: "Date expired of credit card"): "Data",
                         NSLocalizedString("CVV", comment: "CVV code of credit card"): "Int",
                         NSLocalizedString("PIN", comment: "PIN code of credit card"): "Int",
                         NSLocalizedString("Holder", comment: "Holder of credit card"): "String",
                         NSLocalizedString("Notes", comment: "Notes about credit card"): "String"]
        newPattern = PatternRecord(describe: "Credit Card", fields: patternFields, localizedFields: localizedFields, avatar: avatarCreditCardData, kind: PatternKind.creditcard)
        listOfPatterns[PatternKind.creditcard.rawValue] = newPattern

        patternFields = ["Bank": "String",
                         "BankMFO": "Int",
                         "Account": "Int",
                         "Notes": "String"]
        localizedFields = [NSLocalizedString("Bank", comment: "Bank of bank account"): "String",
                         NSLocalizedString("BankMFO", comment: "MFO Bank of bank account"): "Int",
                         NSLocalizedString("Account", comment: "Number of bank account"): "Int",
                         NSLocalizedString("Notes", comment: "Notes about bank account"): "String"]
        newPattern = PatternRecord(describe: "Bank acc.", fields: patternFields, localizedFields: localizedFields, avatar: avatarData3, kind: PatternKind.bankaccount)
        listOfPatterns[PatternKind.bankaccount.rawValue] = newPattern

        patternFields = ["FirstName": "String",
                         "LastName": "String",
                         "MiddleName": "String",
                         "BirthdayDate": "Data",
                         "ReceivedDate": "Data",
                         "SN": "String",
                         "Number": "Int"]
        localizedFields = [NSLocalizedString("FirstName", comment: "FirstName of id card"): "String",
                         NSLocalizedString("LastName", comment: "LastName of id card"): "String",
                         NSLocalizedString("MiddleName", comment: "MiddleName of id card"): "String",
                         NSLocalizedString("BirthdayDate", comment: "BirthdayDate of id card"): "Data",
                         NSLocalizedString("ReceivedDate", comment: "ReceivedDate of id card"): "Data",
                         NSLocalizedString("SN", comment: "Serial number of id card"): "String",
                         NSLocalizedString("Number", comment: "Number of id card"): "Int"]
        newPattern = PatternRecord(describe: "Id Card", fields: patternFields, localizedFields: localizedFields, avatar: avatarIdCardData, kind: PatternKind.idcard)
        listOfPatterns[PatternKind.idcard.rawValue] = newPattern

        list = listOfPatterns
    }
}

