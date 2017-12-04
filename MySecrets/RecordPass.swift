//
//  File.swift
//  MySecrets
//
//  Created by Eric on 12/4/17.
//  Copyright © 2017 Piligrim. All rights reserved.
//

import Foundation

struct RecordPass: Codable {
    var describe : String
    var field1 : String
    var field2 : String
    var exp : Date
    var pass : String
    var avatar : Data
}
