//
//  SecretsBD.swift
//  MySecrets
//
//  Created by Eric on 6/27/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class SecretsDB: Object {
    
    @objc dynamic var data = Data()
    
}
