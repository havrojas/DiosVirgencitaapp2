import SwiftUI
import SafariServices

struct InAppWebBrowserView: View {
    let url: URL
    
    var body: some View {
        SafariView(url: url)
    }
}

fileprivate struct SafariView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SFSafariViewController
    
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // No update needed
    }
}

#Preview {
    InAppWebBrowserView(url: URL(string: "https://www.apple.com")!)
}
