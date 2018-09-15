//
//  CommonFuncs.swift
//  MySecrets
//
//  Created by Eric on 1/28/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class CommonFuncs {
    static func getAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        return alert
    }
    
    static func initRealmDB(inputPasswordStr: String) -> (Bool, String) {
        var userErrorStr = ""
        var inputPasswordStr64 = inputPasswordStr
        while inputPasswordStr64.count < 64 {
            inputPasswordStr64 = "0" + inputPasswordStr64
        }
        if let encryptKey = inputPasswordStr64.data(using: .utf8) {
            //print(encryptKey.count)
            print(Realm.Configuration.defaultConfiguration.fileURL ?? "realm file path doesn't exist")
            let realmConfig = Realm.Configuration(encryptionKey: encryptKey)
            do {
                Secrets.share.realmDB = try Realm(configuration: realmConfig)
            } catch {
                if error.localizedDescription.contains("Realm file decryption failed") {
                    userErrorStr = "Wrong password!"
                } else {
                    userErrorStr = "Error open database!"
                }
                print(error.localizedDescription)
                return (false, userErrorStr)
            }
        } else {
            return (false, "Can't used input password!")
        }
        return (true, "")
    }
    
    static func closeRealmDB() {
        Secrets.share.realmDB = nil
    }
    
    static func readFromRealmDB() -> Bool {
        let listsFromRealm = Secrets.share.realmDB.objects(SecretsDB.self)
        if listsFromRealm.count > 0 {
            if let listFromRealm = listsFromRealm.first {
                if !decodeToMainList(encodedList: listFromRealm.data) {
                    return false
                }
            }
        }
        return true
    }

    static func saveToRealmDB() -> Bool {
        let encodedList = encodeMainList()
        
        let listsFromRealm = Secrets.share.realmDB.objects(SecretsDB.self)
        if listsFromRealm.count > 0 {
            if let listFromRealm = listsFromRealm.first {
                try! Secrets.share.realmDB.write {
                    listFromRealm.data = encodedList
                }
            }
        } else {
            let secretsDB = SecretsDB()
            secretsDB.data = encodedList
            try! Secrets.share.realmDB.write {
                Secrets.share.realmDB.add(secretsDB)
            }
        }
        return true
    }
    
    static func encodeMainList() -> Data {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(Secrets.share.list) {
            return encoded
        } else {
            return Data()
        }
    }

    static func decodeToMainList(encodedList: Data) -> Bool {
        let decoder = JSONDecoder()
        let decodedList_ = try? decoder.decode([RecordPass].self, from: encodedList)
        
        if let decodedList = decodedList_ {
            Secrets.share.list = decodedList
            return true
        } else {
            return false
        }
    }
}

extension String {
    var isContainCorrectCharactersForRealmPassword: (Bool, Int) {
        for (index, unicode) in self.unicodeScalars.enumerated() {
            if (unicode.value < 32 || unicode.value > 127) { //use only latin characters, digits and symbols
                print("not a correcr character")
                print(unicode.value)
                return (false, index)
            }
        }
        return (true, -1)
    }
}
