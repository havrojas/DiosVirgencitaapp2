//dios
//virgencita maria y san jose
//santos y angeles de dios
//  webview4.swift
//  diosvirgencita
//
//  Created by Havit on 03/08/26.
//

import SwiftUI
import WebKit
struct webview4: UIViewRepresentable {
    let urlString: String
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
//#Preview {
   // webview4()
//}
