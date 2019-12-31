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
    @State private var text = "NTOU moto GO"
    @EnvironmentObject var logged : loginState
    @State private var bigPic = false
    @State private var size = CGFloat(200)
    
    var body: some View {
        ZStack{
            Color.yellow
                .edgesIgnoringSafeArea(.all)

            Image("helmet")
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size, alignment: .center)
                .offset(x: 0, y: -250)
                .animation(Animation.default.delay(1))
                .onTapGesture {
                    if self.bigPic{
                        self.size = CGFloat(200)
                    }
                    else{
                        self.size = CGFloat(100)
                    }
                    self.bigPic.toggle()
                }
            
            
            TextField("account",text: $account)
                .cornerRadius(4.0)
                .frame(width: 200.0,height: 30)
                .background(Color.white)
                .offset(x: 0, y: -50)
            SecureField("password",text: $password)
                .cornerRadius(4.0)
                .frame(width: 200.0,height: 30)
                .offset(x: 0, y: 0)
                .background(Color.white)
            Button(action: {
                let decoder = JSONDecoder()
                print("account:\(self.account),password\(self.password)")
                Alamofire.request("https://ntoumotogo.kangs.idv.tw/iosLogin",
                                  method: .post,
                                  parameters: ["Account_name": "\(self.account)", "_password": "\(self.password)"],
                                  encoding: JSONEncoding.default,
                                  headers: nil).responseData { response in
                                    if let data = response.result.value, let content = try? decoder.decode(logGet.self,from:data){
                                        if content.state == true{
                                            print("redirect")
                                            self.logged.state = true
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
            }.offset(x: 0, y: 100)
            Text(text)
                .font(.body)
                .fontWeight(.black)
                .foregroundColor(Color.orange)
                .multilineTextAlignment(.center)
                .onAppear(){
                    print(self.logged.state)
            }
            .offset(x: 0, y: 200)
            
        }.padding()
        
    }
}

struct loginPage_Previews: PreviewProvider {
    static var previews: some View {
        loginPage().environmentObject(loginState())
    }
}
