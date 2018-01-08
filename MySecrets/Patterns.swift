//
//  Patterns.swift
//  MySecrets
//
//  Created by Eric on 12/17/17.
//  Copyright © 2017 EricsApp. All rights reserved.
//

import Foundation

class Patterns {
    static let share = Patterns()
    let list: [String: PatternRecord]
    
    init() {
        var listOfPatterns = [String: PatternRecord]()
        
        var patternFields = ["Login": "String",
                             "Password": "String",
                             "URL": "String",
                             "Notes": "String"]
        var newPattern = PatternRecord(describe: "Websait", fields: patternFields)
        listOfPatterns["websait"] = newPattern

        patternFields = ["Adress": "String",
                         "Login": "String",
                         "Password": "String"]
        newPattern = PatternRecord(describe: "RDP Connection", fields: patternFields)
        listOfPatterns["rdp"] = newPattern

        patternFields = ["Login": "String",
                         "Password": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Account", fields: patternFields)
        listOfPatterns["account"] = newPattern

        patternFields = ["Password": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Password", fields: patternFields)
        listOfPatterns["password"] = newPattern

        patternFields = ["Number": "Int",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Bonus card", fields: patternFields)
        listOfPatterns["bonuscard"] = newPattern

        patternFields = ["SSID": "String",
                         "Password": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "WiFi", fields: patternFields)
        listOfPatterns["wifi"] = newPattern

        patternFields = ["Login": "String",
                         "Password": "String",
                         "POP3": "String",
                         "IMAP": "String",
                         "SMTP": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Email", fields: patternFields)
        listOfPatterns["email"] = newPattern

        patternFields = ["Bank": "String",
                         "NumberCard": "String",
                         "Expired": "Data",
                         "CVV": "Int",
                         "PIN": "Int",
                         "Holder": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Credit Card", fields: patternFields)
        listOfPatterns["creditcard"] = newPattern

        patternFields = ["Bank": "String",
                         "BankMFO": "Int",
                         "Account": "Int",
                         "Notes": "String"]
        newPattern = PatternRecord(describe: "Bank account", fields: patternFields)
        listOfPatterns["bankaccount"] = newPattern

        patternFields = ["FirstName": "String",
                         "LastName": "String",
                         "MiddleName": "String",
                         "RecieveData": "Data",
                         "SN": "String",
                         "Number": "Int"]
        newPattern = PatternRecord(describe: "Id Card", fields: patternFields)
        listOfPatterns["id"] = newPattern

        list = listOfPatterns
    }
}
