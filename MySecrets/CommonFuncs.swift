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
