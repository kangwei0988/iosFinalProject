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
    @EnvironmentObject var logged : loginState
    var body: some View {
        NavigationView {
            List(events.indices, id: \.self) { (index)  in
                NavigationLink(destination: DetailView(info: self.events[index])) {
                    EventRow(event: self.events[index])
                }
            }
            .onAppear {
                Alamofire.request("https://ntoumotogo.kangs.idv.tw/getMatch").responseData { response in
                    if let data = response.result.value, let content = try? decoder.decode([Event].self,from:data){
                        self.events = content
                        }
                        else{
                            print("error")
                        self.logged.state=false
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
