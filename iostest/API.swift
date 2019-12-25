//
//  API.swift
//  iostest
//
//  Created by User21 on 2019/12/24.
//  Copyright © 2019 kang. All rights reserved.
//

import Foundation

func getMatched(completion:@escaping ([Event]?) -> Void){
    let urlStr = "https://ntoumotogo.kangs.idv.tw/getMatch?user=kang"
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    decoder.dateDecodingStrategy = .iso8601
    if let url = URL(string: urlStr) {
        URLSession.shared.dataTask(with: url) { (data, response , error) in
            if let data = data, let content = try? decoder.decode([Event].self,from:data){
                completion(content)
            }
            else{
                print("error")
            }
        }.resume()
    }
}


