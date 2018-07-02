//
//  CommonFuncs.swift
//  MySecrets
//
//  Created by Eric on 1/28/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import Foundation
import UIKit
import Realm

class CommonFuncs {
    static func getAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        return alert
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
