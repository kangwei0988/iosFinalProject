//
//  SwiftUIView.swift
//  iostest
//
//  Created by User21 on 2019/12/11.
//  Copyright © 2019 kang. All rights reserved.
//

import SwiftUI
import Alamofire

struct SwiftUIView: View{
    @State private var events = [Event]()
    var body: some View {
        NavigationView {
            List(events.indices, id: \.self) { (index)  in
                EventRow(event: self.events[index])
            }
            .onAppear {
                Alamofire.request("https://ntoumotogo.kangs.idv.tw/iosLogin",
                           method: .post,
                           parameters: ["Account_name": "kang", "_password": "0988"],
                           encoding: JSONEncoding.default,
                           headers: nil).responseData { response in
                    debugPrint(response)
                }
//                if self.events.count == 0 {
//                    print("in")
//                    getMatched { (data) in
//                        self.events = data!
//                    }
//                }
                let decoder = JSONDecoder()
                Alamofire.request("https://ntoumotogo.kangs.idv.tw/getMatch?user=kang").responseData { response in
                    if let data = response.result.value, let content = try? decoder.decode([Event].self,from:data){
                        self.events = content
                        }
                        else{
                            print("error")
                        }
                    }
                }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
