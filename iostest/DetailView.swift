//
//  DetailView.swift
//  iostest
//
//  Created by User21 on 2019/12/28.
//  Copyright © 2019 kang. All rights reserved.
//

import SwiftUI
import SocketIO
import Alamofire
import AlamofireImage

struct CircleImage: View {
    var tarID : String
    @State var img = Image("ow")
    var body: some View {
        img
            .resizable()
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .frame(width:100,height: 100)
            .onAppear(){self.downLoad(url: self.tarID)}
    }
    func downLoad(url:String) {
        Alamofire.request("https://ntoumotogo.kangs.idv.tw/iosGetUserPic",parameters: ["id":tarID]).responseImage { response in
            if let image = response.result.value {
                self.img = Image(uiImage: image)
            }
            else{
                print("wrong")
            }
        }
    }
}

struct DetailView: View {
    var info: Event
    let socket : SocketIOClient
    @ObservedObject var location : LocationData
    @State var chat :String = ""
    @State private var typeText:String=""
    
    init(info : Event) {
        self.info = info
        location = LocationData(id: info.target_id)
        socket = manager.socket(forNamespace: "/chat")
    }
    
    var body: some View {
        VStack{
            MapView().frame(width: UIScreen.main.bounds.width, height: 300).environmentObject(location)
            //                .onAppear(){self.location.startTimer()}
            //                .onDisappear(){self.location.stopTimer()}
            HStack{
                CircleImage(tarID: info.target_id)
                Spacer()
                Text("與 \(info.sender_name) 的chat").font(.system(size: 30)).fontWeight(.regular).foregroundColor(Color.blue).multilineTextAlignment(.center)
                    .padding(.trailing,50 )
            }
            
            ScrollView{
                Text(chat)
            }
            .frame(width:UIScreen.main.bounds.width)
                .onAppear(){
                    self.socket.on(clientEvent: .connect) {data, ack in
                        self.socket.emitWithAck("joined", ["room":self.info.id]).timingOut(after: 5) { data in
                        }
                        print("socket connected")
                    }
                    
                    self.socket.on("status"){ data, ack in
                        if let arr = data as? [[String: Any]] {
                            if let txt = arr[0]["msg"] as? String {
                                self.chat = txt
                                self.chat=self.chat.replacingOccurrences(of: "</p>", with: "")
                                self.chat=self.chat.replacingOccurrences(of: "<p>", with: "")
                            }
                        }
                    }
                    
                    self.socket.on("message"){ data, ack in
                        if let arr = data as? [[String: Any]] {
                            if let txt = arr[0]["msg"] as? String {
                                self.chat = txt
                                self.chat=self.chat.replacingOccurrences(of: "</p>", with: "")
                                self.chat=self.chat.replacingOccurrences(of: "<p>", with: "")
                            }
                        }
                    }
                    
                    self.socket.connect()
            }
            .onDisappear(){
                print("disconnect")
                self.socket.disconnect()
                self.socket.removeAllHandlers()
            }
            Spacer()
            HStack{
                TextField("type your text here",text: $typeText)
                Button("enter"){
                    self.socket.emitWithAck("text", ["msg":self.typeText,"room":self.info.id]).timingOut(after: 5) { data in
                        self.typeText = ""
                    }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(info:Event(id: "", getOnTime: "", target_id: "5df1d0c666a8c9247f7dc049", post_location: "", post_goto: "", post_notice: "", sender_name: "kang"))
    }
}


//Text(/*@START_MENU_TOKEN@*/"Hello World!"/*@END_MENU_TOKEN@*/).onAppear(){
//    let socket = manager.defaultSocket
//
//    socket.on(clientEvent: .connect) {data, ack in
//        print("socket connected")
//    }
//    socket.on("news"){ index, ack in
//        print("news")
//    }
//    print("hi")
//    socket.connect()
//}
