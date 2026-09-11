//dios
//virgencita y san jose
//arcangeles y santos de dios
//  web3.swift
//  diosvirgencita
//
//  Created by Havit on 29/07/26.
//

import Foundation
import SwiftUI
import WebKit
struct webView3: UIViewRepresentable {
   var url: String
   func makeUIView(context: Context) -> WKWebView {
       guard let url = URL(string: self.url)else {
           return WKWebView()
       }
       let request = URLRequest(url: url)
       let WKWebview = WKWebView()
       WKWebview.load(request)
       return WKWebview
   }
   func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<webView3>) {
       
   }
}

