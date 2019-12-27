//
//  loginPage.swift
//  iostest
//
//  Created by User21 on 2019/12/27.
//  Copyright © 2019 kang. All rights reserved.
//

import SwiftUI
import UIKit
import Alamofire

struct loginPage: View {
    @State private var account = ""
    @State private var password = ""
    @State private var text = ""
    var body: some View {
        VStack{
            Form{
                TextField("account",text: $account)
                TextField("password",text: $password)
                Button(action: {
                    let decoder = JSONDecoder()
                    print("account:\(self.account),password\(self.password)")
                    Alamofire.request("https://ntoumotogo.kangs.idv.tw/iosLogin",
                           method: .post,
                           parameters: ["Account_name": "\(self.account)", "_password": "\(self.password)"],
                           encoding: JSONEncoding.default,
                           headers: nil).responseData { response in
                    if let data = response.result.value, let content = try? decoder.decode(loginState.self,from:data){
                        if content.state == "login"{
                            
                            print("redirect")
                        }
                        else{
                            self.text = "輸入錯誤"
                            print("error")
                        }
                    }
                    else{
                        self.text = "server 500"
                        print("error")
                    }
                    }
                }) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title)
                    Text("登入")
                        .fontWeight(.semibold)
                        .font(.title)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
                .padding(.horizontal, 20)
                }
                Text(text)
            }
        }
    }
}

struct loginPage_Previews: PreviewProvider {
    static var previews: some View {
        loginPage()
    }
}
