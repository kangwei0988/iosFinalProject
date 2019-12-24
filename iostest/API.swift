//
//  API.swift
//  iostest
//
//  Created by User21 on 2019/12/24.
//  Copyright © 2019 kang. All rights reserved.
//

import Foundation

func getMatched(){
    let urlStr = "https://ntoumotogo.kangs.idv.tw/iostest?user=kang"
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    decoder.dateDecodingStrategy = .iso8601
    if let url = URL(string: urlStr) {
        URLSession.shared.dataTask(with: url) { (data, response , error) in
            if let data = data, let content = try? decoder.decode(Event.self,from:data){
                print(content)
                let mydate = dateFormatter.date(from: content.getOnTime)!
                print(mydate)
                print(type(of:mydate))
            }
            else{
                print("error")
            }
        }.resume()
    }
}
