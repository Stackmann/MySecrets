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
    var dataFields: Dictionary<String, Data>
    var field1 : String
    var field2 : String
    var exp : Date
    var pass : String
    var avatar : Data
    var idPattern: String
}
