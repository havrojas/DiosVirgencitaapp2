//dios
//virgencita y san jose
//santos de dios 

import SwiftUI
import WebKit
/*
struct EmbeddedWebPageView4: View {
    let url: URL

    var body: some View {
        WebViewContainer(url: url)
            .navigationTitle(title(from: url))
            .navigationBarTitleDisplayMode(.inline)
    }

    private func title(from url: URL) -> String {
        // Provide a simple readable title from host/path
        if let host = url.host { return host }
        return url.absoluteString
    }
}

private struct WebViewContainer: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        // If the URL changes, reload it
        if webView.url != url {
            webView.load(URLRequest(url: url))
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    final class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }
    }
}
*/

// ... Todo tu código existente de MenuPrincipalView ...
// ... PadreNuestroStyledView, OracionesVirgencitaView, etc. ...


// 👇 PEGAS ESTO HASTA ABAJO DE TU ARCHIVO MENUPRINCIPALVIEW.SWIFT 👇

struct EmbeddedWebPageView4: View {
    let url: URL

    var body: some View {
        AppleMusicWebViewContainer(url: url)
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Playlist de Dios")
            .navigationBarTitleDisplayMode(.inline)
    }
}

private struct AppleMusicWebViewContainer: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = .clear
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}




#Preview {
    NavigationStack {
        EmbeddedWebPageView4(url: URL(string: "https://www.apple.com")!)
    }
}
