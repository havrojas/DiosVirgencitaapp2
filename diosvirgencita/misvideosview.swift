//dios
//virgencita y san jose
//santos y angeles
//  misvideosview.swift
//  diosvirgencita
//
//  Created by Havit on 31/07/26.
//

import SwiftUI
/*
struct VideoDiosWeb: Identifiable {
    let id = UUID()
    let titulo: String
    let descripcion: String
    let extensionArchivo: String? // <- Agrega el '?' aquí
    let youtubeID: String?        // <- Agrega el '?' aquí
    let categoria: String
}
struct misvideosview: View {
    // 📝 AQUÍ ESTÁN TUS VIDEOS ORDENADOS:
    let misVideos: [VideoDiosLocal] = [
        VideoDiosLocal(
            titulo: "Salmo 121",
            descripcion: "Mensaje especial para el día de hoy grabado con mucho amor.",
            nombreArchivo: "video1",
            extensionArchivo: "mp4",
            categoria: "Evangelio"
        ),
        VideoDiosLocal(
            titulo: "Salmo 51",
            descripcion: "Perdón y misericordia.",
            nombreArchivo: "salmo51",
            extensionArchivo: "mp4",
            categoria: "Oración"
        ),
        VideoDiosLocal(
            titulo: "Salmo 37",
            descripcion: "Confía en el Señor y haz el bien.",
            nombreArchivo: "salmo37",
            extensionArchivo: "mp4",
            categoria: "Reflexión"
        ),
        VideoDiosLocal(
            titulo: "Salmo 103",
            descripcion: "Bendice, alma mía, al Señor.",
            nombreArchivo: "salmo103",
            extensionArchivo: "mp4",
            categoria: "Alabanza"
        ),
        VideoDiosLocal(
            titulo: "Salmo 119",
            descripcion: "Bendice, alma mía, al Señor.",
            nombreArchivo: "salmo119",
            extensionArchivo: "mp4",
            categoria: "Alabanza"
        ),
        VideoDiosLocal(
            titulo: "misa en san juan de los lagos",
            descripcion: "La virgencita de san juan.",
            nombreArchivo: "sanjuanita",
            extensionArchivo: "MOV",
            categoria: "Alabanza"
        ),
        VideoDiosLocal(
            titulo: "misa en san juan de los lagos",
            descripcion: "La virgencita de san juan misa.",
            nombreArchivo: "virgencitamisa",
            extensionArchivo: "MOV",
            categoria: "Alabanza"
        ),
        VideoDiosLocal(
            titulo: "san juanita de los lagos celebracion",
            descripcion: "La virgencita de san juan celebracion.",
            nombreArchivo: "viirgencitacelebracion",
            extensionArchivo: "MOV",
            categoria: "Alabanza"
        ),
        VideoDiosLocal(
            titulo: "santisimo sacramento",
            descripcion: "santisimo sacramento misa.",
            nombreArchivo: "santisimosacramento",
            extensionArchivo: "MOV",
            categoria: "Alabanza"
        ),
        VideoDiosLocal(
            titulo: "santisimo sacramento",
            descripcion: "santisimo sacramento misa en su plaza de dios plaza jerusalen.",
            nombreArchivo: "santisimosacramento2",
            extensionArchivo: "MOV",
            categoria: "Alabanza"
        )


    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Encabezado
                    VStack(spacing: 6) {
                        Image(systemName: "film.fill")
                            .font(.system(size: 38))
                            .foregroundColor(.purple)
                            .padding(.top, 10)

                        Text("Mis Videos de Fe")
                            .font(.title2.bold())

                        Text("«Anuncien sus maravillas a todos los pueblos.» (Sal 96, 3)")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 10)

                    // Lista de reproductores
                    ForEach(misVideos) { video in
                        videolocalplayerview(video: video)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .navigationTitle("Videos Propios")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

*/
import AVKit

// MARK: - Modelo de datos para Video desde Web / Supabase
struct VideoDiosWeb: Identifiable {
    let id = UUID()
    let titulo: String
    let descripcion: String
    let urlString: String
    let categoria: String
}

// MARK: - Vista Principal
struct misvideosview: View {
    
    // 📝 TUS VIDEOS CONECTADOS A SUPABASE:
    // (Reemplaza las URLs de ejemplo por tus enlaces de Supabase)
    let misVideos: [VideoDiosWeb] = [
        VideoDiosWeb(
            titulo: "misa en san juan de los lagos",
            descripcion: "La virgencita de san juan.",
            urlString: "https://jisjgekbmpfhepvucdjm.supabase.co/storage/v1/object/public/videos/virgencitamisa.mp4",
            categoria: "Alabanza"
        ),
        VideoDiosWeb(
            titulo: "misa en san juan de los lagos",
            descripcion: "La virgencita de san juan misa.",
            urlString: "https://jisjgekbmpfhepvucdjm.supabase.co/storage/v1/object/public/videos/sanjuanita.mp4",
            categoria: "Alabanza"
        ),
        VideoDiosWeb(
            titulo: "san juanita de los lagos celebracion",
            descripcion: "La virgencita de san juan celebracion.",
            urlString: "https://jisjgekbmpfhepvucdjm.supabase.co/storage/v1/object/public/videos/celebracion2.mp4",
            categoria: "Alabanza"
        ),
        VideoDiosWeb(
            titulo: "santisimo sacramento",
            descripcion: "santisimo sacramento misa.",
            urlString: "https://jisjgekbmpfhepvucdjm.supabase.co/storage/v1/object/public/videos/santisimosacramento.mp4",
            categoria: "Alabanza"
        ),
        VideoDiosWeb(
            titulo: "santisimo sacramento",
            descripcion: "santisimo sacramento misa en su plaza de dios plaza jerusalen.",
            urlString: "https://jisjgekbmpfhepvucdjm.supabase.co/storage/v1/object/public/videos/santisimosacramento2.mp4",
            categoria: "Alabanza"
        )
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Encabezado
                    VStack(spacing: 6) {
                        Image(systemName: "film.fill")
                            .font(.system(size: 38))
                            .foregroundColor(.purple)
                            .padding(.top, 10)

                        Text("Mis Videos de Fe")
                            .font(.title2.bold())

                        Text("«Anuncien sus maravillas a todos los pueblos.» (Sal 96, 3)")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 10)

                    // Lista de reproductores desde la Web
                    ForEach(misVideos) { video in
                        videowebplayerview(video: video)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .navigationTitle("Videos Propios")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Componente Reproductor de Video Web
struct videowebplayerview: View {
    let video: VideoDiosWeb
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // Reproductor AVPlayer consumiendo la URL de Supabase
            if let videoURL = URL(string: video.urlString) {
                VideoPlayer(player: AVPlayer(url: videoURL))
                    .frame(height: 220)
                    .cornerRadius(12)
                    .shadow(radius: 4)
            } else {
                ContentUnavailableView("Error de video", systemImage: "exclamationmark.triangle")
                    .frame(height: 220)
            }
            
            // Información del video
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(video.categoria.uppercased())
                        .font(.caption2.bold())
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.purple.opacity(0.15))
                        .foregroundColor(.purple)
                        .cornerRadius(6)
                    
                    Spacer()
                }
                
                Text(video.titulo)
                    .font(.headline)
                
                Text(video.descripcion)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 4)
        }
        .padding(12)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(16)
    }
}
#Preview {
    misvideosview()
}
