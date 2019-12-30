//
//  WebView.swift
//  iostest
//
//  Created by User21 on 2019/12/28.
//  Copyright © 2019 kang. All rights reserved.
//
//just copy from this website : https://forums.developer.apple.com/thread/117348
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let request: URLRequest
          
        func makeUIView(context: Context) -> WKWebView  {
            return WKWebView()
        }
          
        func updateUIView(_ uiView: WKWebView, context: Context) {
            uiView.load(request)
        }
}
      
#if DEBUG
struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(request: URLRequest(url: URL(string: "https://www.apple.com")!))
    }
}
#endif
