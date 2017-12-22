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
    let list: [PatternRecord]
    
    init() {
        var listOfPatterns = [PatternRecord]()
        
        var patternFields = ["Login": "String",
                             "Password": "String",
                             "URL": "String",
                             "Notes": "String"]
        var newPattern = PatternRecord(id: "websait", fields: patternFields)
        listOfPatterns.append(newPattern)

        patternFields = ["Adress": "String",
                         "Login": "String",
                         "Password": "String"]
        newPattern = PatternRecord(id: "rdp", fields: patternFields)
        listOfPatterns.append(newPattern)
        
        patternFields = ["Login": "String",
                         "Password": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(id: "account", fields: patternFields)
        listOfPatterns.append(newPattern)

        patternFields = ["Password": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(id: "password", fields: patternFields)
        listOfPatterns.append(newPattern)

        patternFields = ["Number": "Int",
                         "Notes": "String"]
        newPattern = PatternRecord(id: "bonuscard", fields: patternFields)
        listOfPatterns.append(newPattern)

        patternFields = ["SSID": "String",
                         "Password": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(id: "wifi", fields: patternFields)
        listOfPatterns.append(newPattern)

        patternFields = ["Login": "String",
                         "Password": "String",
                         "POP3": "String",
                         "IMAP": "String",
                         "SMTP": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(id: "email", fields: patternFields)
        listOfPatterns.append(newPattern)

        patternFields = ["Bank": "String",
                         "NumberCard": "Int",
                         "Expired": "Data",
                         "CVV": "Int",
                         "PIN": "Int",
                         "Holder": "String",
                         "Notes": "String"]
        newPattern = PatternRecord(id: "creditcard", fields: patternFields)
        listOfPatterns.append(newPattern)

        patternFields = ["Bank": "String",
                         "BankMFO": "Int",
                         "Account": "Int",
                         "Notes": "String"]
        newPattern = PatternRecord(id: "bankaccount", fields: patternFields)
        listOfPatterns.append(newPattern)

        patternFields = ["FirstName": "String",
                         "LastName": "String",
                         "MiddleName": "String",
                         "RecieveData": "Data",
                         "SN": "String",
                         "Number": "Int"]
        newPattern = PatternRecord(id: "id", fields: patternFields)
        listOfPatterns.append(newPattern)
        
        list = listOfPatterns
    }
}
