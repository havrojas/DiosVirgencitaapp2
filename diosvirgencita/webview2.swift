//dios
//virgencita y san jose
//dios sus arcangeles y santos de dios
//  webview2.swift
//  diosvirgencita
//
//  Created by Havit on 29/07/26.
//

import SwiftUI
import WebKit
// MARK: - Modelo para la Playlist
struct Playlist: Identifiable {
    let id = UUID()
    let titulo: String
    let descripcion: String
    let url: String
}

// MARK: - Vista Principal de Música
struct webview2: View {
    var onVolverAlMenu: () -> Void = {}
    
    // 🔗 TUS DOS PLAYLISTS (Corregido con dos puntos ':')
    let misPlaylists: [Playlist] = [
        Playlist(
            titulo: "Alabanzas y Cantos Celestiales",
            descripcion: "Música para orar y meditar en la presencia de Dios",
            url: "https://music.apple.com/mx/playlist/dios/pl.u-jV89b7NtDX2e53m"
        ),
        Playlist(
            titulo : "Música Virgencita",
            descripcion: "Cantos y oraciones devocionales",
            url: "https://music.apple.com/mx/playlist/diosvirgencitaapp/pl.u-xlyNq92uJ957Yey"
        )
    ]
    
    @State private var playlistSeleccionada: Playlist? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()
                
                if let playlist = playlistSeleccionada {
                    SwiftUIWebView(urlString: playlist.url)
                        .navigationTitle(playlist.titulo)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    playlistSeleccionada = nil
                                }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "chevron.left")
                                        Text("Playlists")
                                    }
                                    .foregroundColor(.blue)
                                }
                            }
                        }
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(misPlaylists) { playlist in
                                TarjetaPlaylistView(playlist: playlist) {
                                    playlistSeleccionada = playlist
                                }
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Listas de Música")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                             
                            }
                        }
                    }
                }
            }
        }
    }

// MARK: - Tarjeta Visual
struct TarjetaPlaylistView: View {
    let playlist: Playlist
    let onClick: () -> Void
    
    var body: some View {
        Button(action: onClick) {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.green.opacity(0.15))
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: "music.note")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.green)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(playlist.titulo)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(playlist.descripcion)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                Image(systemName: "play.circle.fill")
                    .font(.title2)
                    .foregroundColor(.green)
            }
            .padding()
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Componente WebView para Swift
struct SwiftUIWebView: UIViewRepresentable {
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


    //✝️
#Preview {
    webview2()
}
