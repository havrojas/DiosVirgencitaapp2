//dios
//virgencita y san jose
//angeles de dios y arcangeles
//  web2.swift
//  diosvirgencita
//✝️Dios señal el Espíritu Santo esta en mi✝️
//  Created by Havit on 29/07/26.
//

import Foundation
 import SwiftUI
import WebKit
struct webView: UIViewRepresentable {
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
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<webView>) {
        
    }
}

