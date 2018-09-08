//
//  File.swift
//  MySecrets
//
//  Created by Eric on 12/17/17.
//  Copyright © 2017 EricsApp. All rights reserved.
//

import Foundation

struct PatternRecord {
    let describe: String
    let fields: [String]
    let typesOfFields: Dictionary<String, String>
    let localizedFields: Dictionary<String, String>
    let avatar: Data
    let kind: PatternKind
}

enum PatternKind: String {
    case websait = "websait"
    case rdp = "rdp"
    case account = "account"
    case password = "password"
    case bonuscard = "bonuscard"
    case wifi = "wifi"
    case email = "email"
    case creditcard = "creditcard"
    case bankaccount = "bankaccount"
    case idcard = "idcard"
}
