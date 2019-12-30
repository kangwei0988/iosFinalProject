//
//  MainView.swift
//  iostest
//
//  Created by User21 on 2019/12/28.
//  Copyright © 2019 kang. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var logged : loginState
    var body: some View {
        TabView{
            SwiftUIView().tabItem{Image(systemName: "music.house.fill")
                Text("schedual")
            }
            WebView(request: URLRequest(url: URL(string: "https://ntoumotogo.kangs.idv.tw")!)).tabItem{Image(systemName: "music.house.fill")
                Text("web")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
