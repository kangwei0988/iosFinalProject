//
//  Data.swift
//  iostest
//
//  Created by User21 on 2019/12/24.
//  Copyright © 2019 kang. All rights reserved.
//

import Foundation

struct Event :Codable{
    var id : String
    var getOnTime : String
    var target_id : String
    var post_location:String
    var post_goto :String
    var post_notice:String
    var sender_name:String
}
struct Login: Encodable {
    let Account_name: String
    let _password: String
}

let login = Login(Account_name: "kang", _password: "0988")


