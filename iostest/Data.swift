//
//  Data.swift
//  iostest
//
//  Created by User21 on 2019/12/24.
//  Copyright © 2019 kang. All rights reserved.
//

import Foundation
import MapKit
import Alamofire


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
    var Account_name: String
    var _password: String
}

struct logGet :Codable{
    var state : Bool
}

class loginState :ObservableObject{
    @Published var state : Bool
    init() {
        state = false
    }
}

struct Location: Codable{
    var lat : Double
    var lng : Double
}

struct chatRecord: Codable{
    var msg : String
    var tarName1 : String
    var tarName2 : String
}

class LocationData:ObservableObject{
    var id : String
    let decoder = JSONDecoder()
    @Published var location = CLLocationCoordinate2D(latitude: 25, longitude: 121)
    var timer: Timer?
    
    init(id:String) {
        self.id = id
        let decoder = JSONDecoder()
        Alamofire.request("https://ntoumotogo.kangs.idv.tw/iosReturnLocation",parameters: ["id":id]).responseData { response in
        if let data = response.result.value, let content = try? decoder.decode(Location.self,from:data){
            print("update")
            print(content.lat)
            self.location = CLLocationCoordinate2D(
                    latitude: content.lat, longitude: content.lng)
            }
            else{
                print("error")
            }
        }
    }
    
    func startTimer(){
        self.timer=Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            Alamofire.request("https://ntoumotogo.kangs.idv.tw/iosReturnLocation",parameters: ["id":self.id]).responseData { response in
                if let data = response.result.value, let content = try? self.decoder.decode(Location.self,from:data){
                print("update")
                print(content.lat)
                self.location = CLLocationCoordinate2D(
                        latitude: content.lat, longitude: content.lng)
                }
                else{
                    print("error")
                }
            }
        }
    }
    
    func stopTimer(){
        self.timer?.invalidate()
    }
}



