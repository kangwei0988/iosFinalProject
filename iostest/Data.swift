//
//  Data.swift
//  iostest
//
//  Created by User21 on 2019/12/24.
//  Copyright © 2019 kang. All rights reserved.
//

import Foundation

struct Event :Codable,Identifiable,Hashable{
    var id : String
    var getOnTime : String
    var target_id : String
    var post_location:String
    var post_goto :String
    var post_notice:String
    var sender_name:String
}
