//
//  SettingView.swift
//  iostest
//
//  Created by User21 on 2019/12/30.
//  Copyright © 2019 kang. All rights reserved.
//

import SwiftUI
import Alamofire

struct SettingView: View {
    @EnvironmentObject var logged : loginState
    @State private var showSelectPhoto = false
    @State private var selectImage: UIImage?
    
    var body: some View {
        VStack {
            Text("my head photo")
            Group {
                if selectImage == nil {
                    Image(systemName: "photo")
                        .resizable()
                    
                } else {
                    Image(uiImage: selectImage!)
                        .resizable()
                        .renderingMode(.original).onAppear(){print("reload pic")}
                }
                
            }
            .contextMenu(){
                //print(self.selectImage)
                Button(action: {
                    self.showSelectPhoto = true
                }){
                    Text("upload pic")
                }
                Button(action:{
                    if self.selectImage != nil {
                        let imageName = UUID().uuidString+".png"
                        guard let data = self.selectImage!.jpegData(compressionQuality: 0.5) else {
                            print("wrong")
                            return
                        }
                        let url = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask).first!.appendingPathComponent(imageName)
                        print(url)
                        do {
                            try data.write(to: url)
                        } catch {
                            print("write error")
                        }
                    }
                    else{
                        print("no pic")
                    }
                }){
                    Text("download pic")
                }
            }
            .scaledToFill()
            .frame(width: 200, height: 200)
            .clipped()
            Text("long tap it")
        }.onAppear(){
            Alamofire.request("https://ntoumotogo.kangs.idv.tw/iosGetMyPic").responseImage { response in
                if let img = response.result.value {
                    self.selectImage = img
                }
                else{
                    print("wrong")
                }
            }
        }.sheet(isPresented: $showSelectPhoto) {
            ImagePickerController(selectImage: self.$selectImage, showSelectPhoto: self.$showSelectPhoto)
        }
    }
    
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
