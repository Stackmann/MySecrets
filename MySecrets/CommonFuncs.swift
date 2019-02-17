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
            let realmDefaultConfig = Realm.Configuration(encryptionKey: encryptKey)
            if Secrets.share.realmDBConfiguration == nil {
               Secrets.share.realmDBConfiguration = realmDefaultConfig
            } else {
                Secrets.share.realmDBConfiguration?.encryptionKey = encryptKey
            }
            print(Secrets.share.realmDBConfiguration?.fileURL ?? "realm file path doesn't exist")
            do {
                Secrets.share.realmDB = try Realm(configuration: Secrets.share.realmDBConfiguration!)
            } catch {
                if error.localizedDescription.contains("Realm file decryption failed") {
                    userErrorStr = NSLocalizedString("ErrorWrongPasswordText", comment: "Error wrong password")
                } else {
                    userErrorStr = NSLocalizedString("ErrorOpenDatabaseText", comment: "Error open database")
                }
                print(error.localizedDescription)
                return (false, userErrorStr)
            }
        } else {
            userErrorStr = NSLocalizedString("ErrorUsedInputPasswordText", comment: "Error use input password")
            return (false, userErrorStr)
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

    static func changeKeyRealmDB(newPasswordStr: String) -> (Bool, String) {
        //remove old file DB
        Secrets.share.dataAvailable = false
        let realmURL = Secrets.share.realmDBConfiguration!.fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        for URL in realmURLs {
            do {
                try FileManager.default.removeItem(at: URL)
            } catch {
                let sysErrorStr = NSLocalizedString("ErrorChangePasswordText", comment: "Error change password")
                return(false, sysErrorStr)
            }
        }

        //create new file DB with new encryptkey
        let resultInitDB = CommonFuncs.initRealmDB(inputPasswordStr: newPasswordStr)
        if !resultInitDB.0 {
            return (false, resultInitDB.1)
        }
        //save all secrets to DB
        if !saveToRealmDB() { return (false, "Something wents wrong!") }
        
        Secrets.share.dataAvailable = true
        return (true, "")
    }

    static func isRealmDBPresent() -> Bool {
        if let _ = Secrets.share.realmDBConfiguration {
            return true
        } else if let defaultCfgURL = Realm.Configuration().fileURL,
            FileManager.default.fileExists(atPath: defaultCfgURL.path) {
            return true
        } else {
            return false
        }
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
    
    static func returnNextNameRealmFile(for previousName: String) -> String {
        var nextName = previousName
        if var currentIndex = previousName.range(of: ".realm")?.lowerBound {
            var currentCharacter = previousName[previousName.startIndex]
            var strNumber = ""
            while currentIndex > previousName.startIndex {
                currentIndex = previousName.index(before: currentIndex)
                currentCharacter = previousName[currentIndex]
                //digits value >= 48 && value <= 57
                if CharacterSet.decimalDigits.contains(currentCharacter.unicodeScalar()) {
                    strNumber.insert(currentCharacter, at: strNumber.startIndex)
                } else {
                    break
                }
            }
            if strNumber.isEmpty {
                nextName = "default1.realm"
            } else {
                if var number = Int(strNumber) {
                    number += 1
                    nextName = "default" + String(number) + ".realm"
                }
            }
        }
        return nextName
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

extension Character {
    func unicodeScalarCodePoint() -> UInt32 {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        
        return scalars[scalars.startIndex].value
    }

    func unicodeScalar() -> UnicodeScalar {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        
        return scalars[scalars.startIndex]
    }
}
