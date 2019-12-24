//
//  SwiftUIView.swift
//  iostest
//
//  Created by User21 on 2019/12/11.
//  Copyright © 2019 kang. All rights reserved.
//

import SwiftUI

let urlString = "http://ntoumotogo.kangs.idv.tw/iostest"
struct SwiftUIView: View{
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello World!"/*@END_MENU_TOKEN@*/).onAppear(){getMatched()}
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
