//
//  File.swift
//  MySecrets
//
//  Created by Eric on 12/4/17.
//  Copyright © 2017 EricsApp. All rights reserved.
//

import Foundation

struct RecordPass: Codable {
    var describe : String
    var stringFields: Dictionary<String, String>
    var decimalFields: Dictionary<String, Int>
    var dateFields: Dictionary<String, Date>
    var avatar : Data
    var idPattern: String
    var num: Int
}
