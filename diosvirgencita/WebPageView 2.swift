//dios
//virgencita y san jose
//santos de dios
import SwiftUI
import WebKit

struct EmbeddedWebPageView: View {
    let url: URL
    @State private var isLoading: Bool = true
    @State private var estimatedProgress: Double = 0

    var body: some View {
        ZStack {
            InlineWebViewRepresentable(url: url, isLoading: $isLoading, estimatedProgress: $estimatedProgress)
                .ignoresSafeArea(edges: .bottom)

            if isLoading {
                VStack(spacing: 12) {
                    ProgressView(value: estimatedProgress)
                        .progressViewStyle(.linear)
                        .tint(.accentColor)
                        .frame(maxWidth: 240)
                    Text("Cargando…")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct InlineWebViewRepresentable: UIViewRepresentable {
    let url: URL
    @Binding var isLoading: Bool
    @Binding var estimatedProgress: Double

    func makeCoordinator() -> Coordinator {
        Coordinator(isLoading: $isLoading, estimatedProgress: $estimatedProgress)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        webView.customUserAgent = nil

        // Observe progress
        webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

        // Load initial request
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // If the URL changed, reload.
        if uiView.url != url {
            uiView.load(URLRequest(url: url))
        }
    }

    static func dismantleUIView(_ uiView: WKWebView, coordinator: Coordinator) {
        uiView.removeObserver(coordinator, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }

    final class Coordinator: NSObject, WKNavigationDelegate {
        @Binding var isLoading: Bool
        @Binding var estimatedProgress: Double

        init(isLoading: Binding<Bool>, estimatedProgress: Binding<Double>) {
            self._isLoading = isLoading
            self._estimatedProgress = estimatedProgress
        }

        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == #keyPath(WKWebView.estimatedProgress), let webView = object as? WKWebView {
                estimatedProgress = webView.estimatedProgress
            }
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            isLoading = false
            estimatedProgress = 1
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            isLoading = false
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            isLoading = false
        }
    }
}

