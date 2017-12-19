//
//  Secrets.swift
//  MySecrets
//
//  Created by Eric on 11/29/17.
//  Copyright © 2017 EricsApp. All rights reserved.
//

import Foundation
import UIKit


class Secrets {
    static let share = Secrets()
    
    var list : [RecordPass]?
    
    func loadData() {
        if var arrayOfSecrets = list { arrayOfSecrets.removeAll() }
        
        guard let avatar1 = UIImage(named: "if_credit_card_49367") else { return }
        guard let avatar2 = UIImage(named: "if_credit-cards_47679") else { return }
        guard let avatar3 = UIImage(named: "if_lock_49374") else { return }
        guard let avatar4 = UIImage(named: "if_secure-payment_47685") else { return }
        guard let avatar5 = UIImage(named: "if_user_info_49399") else { return }
        guard let avatarData1 = UIImagePNGRepresentation(avatar1) else { return }
        guard let avatarData2 = UIImagePNGRepresentation(avatar2) else { return }
        guard let avatarData3 = UIImagePNGRepresentation(avatar3) else { return }
        guard let avatarData4 = UIImagePNGRepresentation(avatar4) else { return }
        guard let avatarData5 = UIImagePNGRepresentation(avatar5) else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let date1 = formatter.date(from: "2017/11/16 14:53") else { return }
        
        let firstPass = RecordPass(describe: "My password", stringFields: ["Login":"Eric", "Password":"qwerty", "URL":"", "Notes":""], decimalFields: [String: Int](), dateFields: [String: Date](), avatar: avatarData1, idPattern: "websait")
        
        let secondPass = RecordPass(describe: "MyCard2", stringFields: ["Bank":"Privat", "Holder":"Eric Johns", "Notes":""], decimalFields: ["Number": 1111222233334444], dateFields: ["Expired": date1], avatar: avatarData2, idPattern: "creditcard")
        
        let thirdPass = RecordPass(describe: "MyCard3", stringFields: ["Bank":"USB", "Holder":"Eric Johns", "Notes":""], decimalFields: ["Number": 2222111133334444], dateFields: ["Expired": date1], avatar: avatarData3, idPattern: "creditcard")
        
        let fourPass = RecordPass(describe: "Шифр сейфа", stringFields: ["Password":"qwerty", "Notes":"Input with pause"], decimalFields: [String: Int](), dateFields: [String: Date](), avatar: avatarData4, idPattern: "password")
        
        let fivePass = RecordPass(describe: "Удостоверение", stringFields: ["FirstName":"Eric", "LastName":"Johns", "MiddleName":"Sasha", "SN":"MB"], decimalFields: ["Number": 102030], dateFields: ["RecieveData": date1], avatar: avatarData5, idPattern: "id")

        list = [firstPass, secondPass, thirdPass, fourPass, fivePass]
        
        //        let encoder = JSONEncoder()
        
        //        if let encoded = try? encoder.encode(mySecrets.list) {
        //            print(encoded)
        //        }

    }
    
}
