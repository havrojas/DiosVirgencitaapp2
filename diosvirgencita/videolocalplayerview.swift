//
//  videolocalplayerview.swift
//  diosvirgencita
//
//  Created by Havit on 31/07/26.
//

import SwiftUI
import AVKit
struct VideoDiosLocal: Identifiable {
    let id = UUID()
    let titulo: String
    let descripcion: String
    let nombreArchivo: String
    let extensionArchivo: String
    let categoria: String
}
struct videolocalplayerview: View {
    let video: VideoDiosLocal
    @State private var player: AVPlayer?
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // 🎬 Reproductor Nativo de Video
            if let player = player {
                VideoPlayer(player: player)
                    .frame(height: 220)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 220)
                    .cornerRadius(12)
                    .overlay(
                        Text("No se pudo cargar el video local")
                            .font(.caption)
                            .foregroundColor(.gray)
                    )
            }
            
            // ℹ️ Información del Video
            VStack(alignment: .leading, spacing: 6) {
                Text(video.categoria.uppercased())
                    .font(.caption2.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.purple.opacity(0.12))
                    .foregroundColor(.purple)
                    .cornerRadius(6)
                
                Text(video.titulo)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(video.descripcion)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 4)
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .onAppear {
            // Busca el video local en el paquete de la app
            if let url = Bundle.main.url(forResource: video.nombreArchivo, withExtension: video.extensionArchivo) {
                player = AVPlayer(url: url)
            }
        }
        .onDisappear {
            // Pausa el video si el usuario sale de la pantalla
            player?.pause()
        }
    }
}
#Preview {
    videolocalplayerview(
            video: VideoDiosLocal(
                titulo: "Video de Prueba",
                descripcion: "Vista previa del video",
                nombreArchivo: "ejemplo",
                extensionArchivo: "mp4",
                categoria: "Reflexión"
            )
        )
}
