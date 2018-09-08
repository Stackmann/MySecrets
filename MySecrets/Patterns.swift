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
        
        var fields = ["Login","Password","URL","Notes"]
        var typesOfFields = ["Login": "String",
                             "Password": "String",
                             "URL": "String",
                             "Notes": "String"]
        var localizedFields = ["Login": NSLocalizedString("Login", comment: "Login to websait"),
                               "Password": NSLocalizedString("Password", comment: "Password to websait"),
                               "URL": NSLocalizedString("URL", comment: "URL of websait"),
                               "Notes": NSLocalizedString("Notes", comment: "Notes about secret")]
        var newPattern = PatternRecord(describe: "Websait", fields: fields, typesOfFields: typesOfFields, localizedFields: localizedFields, avatar: avatarWWWData, kind: PatternKind.websait)
        listOfPatterns[PatternKind.websait.rawValue] = newPattern

        fields = ["Adress","Login","Password"]
        typesOfFields = ["Adress": "String",
                         "Login": "String",
                         "Password": "String"]
        localizedFields = ["Adress": NSLocalizedString("Adress", comment: "Adress of RDP server"),
                           "Login": NSLocalizedString("Login", comment: "Login to RDP server"),
                           "Password": NSLocalizedString("Password", comment: "Password to RDP server")]
        newPattern = PatternRecord(describe: "RDP", fields: fields, typesOfFields: typesOfFields, localizedFields: localizedFields, avatar: avatarRDPData, kind: PatternKind.rdp)
        listOfPatterns[PatternKind.rdp.rawValue] = newPattern

        fields = ["Login","Password","Notes"]
        typesOfFields = ["Login": "String",
                         "Password": "String",
                         "Notes": "String"]
        localizedFields = ["Login": NSLocalizedString("Login", comment: "Login of account"),
                           "Password": NSLocalizedString("Password", comment: "Password of account"),
                           "Notes": NSLocalizedString("Notes", comment: "Notes about account")]
        newPattern = PatternRecord(describe: "Account", fields: fields, typesOfFields: typesOfFields, localizedFields: localizedFields, avatar: avatarAccountData, kind: PatternKind.account)
        listOfPatterns[PatternKind.account.rawValue] = newPattern

        fields = ["Password","Notes"]
        typesOfFields = ["Password": "String",
                         "Notes": "String"]
        localizedFields = ["Password": NSLocalizedString("Password", comment: "Password of secret with pattern Password"),
                           "Notes": NSLocalizedString("Notes", comment: "Notes of secret with pattern Password")]
        newPattern = PatternRecord(describe: "Password", fields: fields, typesOfFields: typesOfFields, localizedFields: localizedFields, avatar: avatarPasswordData, kind: PatternKind.password)
        listOfPatterns[PatternKind.password.rawValue] = newPattern

        fields = ["Number","Notes"]
        typesOfFields = ["Number": "Int",
                         "Notes": "String"]
        localizedFields = ["Number": NSLocalizedString("Number", comment: "Number of bonus card"),
                           "Notes": NSLocalizedString("Notes", comment: "Notes of bonus card")]
        newPattern = PatternRecord(describe: "Bonus card", fields: fields, typesOfFields: typesOfFields, localizedFields: localizedFields, avatar: avatarBonusCardData, kind: PatternKind.bonuscard)
        listOfPatterns[PatternKind.bonuscard.rawValue] = newPattern

        fields = ["SSID","Password","Notes"]
        typesOfFields = ["SSID": "String",
                         "Password": "String",
                         "Notes": "String"]
        localizedFields = ["SSID": NSLocalizedString("SSID", comment: "SSID of WiFi networks"),
                           "Password": NSLocalizedString("Password", comment: "Key phrase of WiFi networks"),
                           "Notes": NSLocalizedString("Notes", comment: "Notes of WiFi networks")]
        newPattern = PatternRecord(describe: "WiFi", fields: fields, typesOfFields: typesOfFields, localizedFields: localizedFields, avatar: avatarWiFiData, kind: PatternKind.wifi)
        listOfPatterns[PatternKind.wifi.rawValue] = newPattern

        fields = ["Login","Password","POP3","IMAP","SMTP","Notes"]
        typesOfFields = ["Login": "String",
                         "Password": "String",
                         "POP3": "String",
                         "IMAP": "String",
                         "SMTP": "String",
                         "Notes": "String"]
        localizedFields = ["Login": NSLocalizedString("Login", comment: "Login of email authorization"),
                           "Password": NSLocalizedString("Password", comment: "Password of email authorization"),
                           "POP3": NSLocalizedString("POP3", comment: "POP3 server of email"),
                           "IMAP": NSLocalizedString("IMAP", comment: "IMAP server of email"),
                           "SMTP": NSLocalizedString("SMTP", comment: "SMTP server of email"),
                           "Notes": NSLocalizedString("Notes", comment: "Notes about email")]
        newPattern = PatternRecord(describe: "Email", fields: fields, typesOfFields: typesOfFields, localizedFields: localizedFields, avatar: avatarEmailData, kind: PatternKind.email)
        listOfPatterns[PatternKind.email.rawValue] = newPattern

        fields = ["Bank","NumberCard","Expired","CVV","PIN","Holder","Notes"]
        typesOfFields = ["Bank": "String",
                         "NumberCard": "String",
                         "Expired": "Data",
                         "CVV": "Int",
                         "PIN": "Int",
                         "Holder": "String",
                         "Notes": "String"]
        localizedFields = ["Bank": NSLocalizedString("Bank", comment: "Bank of credit card"),
                           "NumberCard": NSLocalizedString("NumberCard", comment: "Number of credit card"),
                           "Expired": NSLocalizedString("Expired", comment: "Date expired of credit card"),
                           "CVV": NSLocalizedString("CVV", comment: "CVV code of credit card"),
                           "PIN": NSLocalizedString("PIN", comment: "PIN code of credit card"),
                           "Holder": NSLocalizedString("Holder", comment: "Holder of credit card"),
                           "Notes": NSLocalizedString("Notes", comment: "Notes about credit card")]
        newPattern = PatternRecord(describe: "Credit Card", fields: fields, typesOfFields: typesOfFields, localizedFields: localizedFields, avatar: avatarCreditCardData, kind: PatternKind.creditcard)
        listOfPatterns[PatternKind.creditcard.rawValue] = newPattern

        fields = ["Bank","BankMFO","Account","Notes"]
        typesOfFields = ["Bank": "String",
                         "BankMFO": "Int",
                         "Account": "Int",
                         "Notes": "String"]
        localizedFields = ["Bank": NSLocalizedString("Bank", comment: "Bank of bank account"),
                           "BankMFO": NSLocalizedString("BankMFO", comment: "MFO Bank of bank account"),
                           "Account": NSLocalizedString("Account", comment: "Number of bank account"),
                           "Notes": NSLocalizedString("Notes", comment: "Notes about bank account")]
        newPattern = PatternRecord(describe: "Bank acc.", fields: fields, typesOfFields: typesOfFields, localizedFields: localizedFields, avatar: avatarData3, kind: PatternKind.bankaccount)
        listOfPatterns[PatternKind.bankaccount.rawValue] = newPattern

        fields = ["FirstName","LastName","MiddleName","BirthdayDate","ReceivedDate","SN","Number"]
        typesOfFields = ["FirstName": "String",
                         "LastName": "String",
                         "MiddleName": "String",
                         "BirthdayDate": "Data",
                         "ReceivedDate": "Data",
                         "SN": "String",
                         "Number": "Int"]
        localizedFields = ["FirstName": NSLocalizedString("FirstName", comment: "FirstName of id card"),
                           "LastName": NSLocalizedString("LastName", comment: "LastName of id card"),
                           "MiddleName": NSLocalizedString("MiddleName", comment: "MiddleName of id card"),
                           "BirthdayDate": NSLocalizedString("BirthdayDate", comment: "BirthdayDate of id card"),
                           "ReceivedDate": NSLocalizedString("ReceivedDate", comment: "ReceivedDate of id card"),
                           "SN": NSLocalizedString("SN", comment: "Serial number of id card"),
                           "Number": NSLocalizedString("Number", comment: "Number of id card")]
        newPattern = PatternRecord(describe: "Id Card", fields: fields, typesOfFields: typesOfFields, localizedFields: localizedFields, avatar: avatarIdCardData, kind: PatternKind.idcard)
        listOfPatterns[PatternKind.idcard.rawValue] = newPattern

        list = listOfPatterns
    }
}

