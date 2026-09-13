//dios
//virgencita y san jose
//dios sus angeles y santos
//  rosario.swift
//  diosvirgencita
//
//  Created by Havit on 31/07/26.
//

import SwiftUI
import AVFoundation
 /*
struct rosario: View {
    // 1. Las variables van AQUÍ arriba:
        @StateObject private var playerManager = AudioPlayerManager()

        // 2. Toda la interfaz (botones, textos, stacks) va dentro del body:
        var body: some View {
            VStack(spacing: 20) {
                
                // Botón para reproducir tu voz
                Button(action: {
                    if playerManager.isPlaying {
                        playerManager.detenerAudio()
                    } else {
                        playerManager.reproducirAudio(nombreArchivo: "rosario", extensionArchivo: "m4a")
                    }
                }) {
                    HStack {
                        Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                        Text(playerManager.isPlaying ? "Pausar" : "Escuchar mi voz dios")
                    }
                    .font(.headline)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }

            }
        }
    }
#Preview {
   
    rosario()
}
*/
struct rosario: View {
    @ObservedObject var playerManager = AudioPlayerManager()
    @State private var isNovenaExpanded: Bool = false
    
    let audiosNovena = [
        (titulo: "Día 1: Por el don del Temor de Dios", urlAudio: "https://jisjgekbmpfhepvucdjm.supabase.co/storage/v1/object/public/videos/novena_dia1.m4a"),
        (titulo: "Día 2: Por el don de Piedad", urlAudio: "https://tupaginaweb.com/audios/novena_dia2.m4a"),
        (titulo: "Día 3: Por el don de Fortaleza", urlAudio: "https://tupaginaweb.com/audios/novena_dia3.m4a"),
        (titulo: "Día 4: Por el don de Conocimiento", urlAudio: "https://tupaginaweb.com/audios/novena_dia4.m4a"),
        (titulo: "Día 5: Por el don de Consejo", urlAudio: "https://tupaginaweb.com/audios/novena_dia5.m4a"),
        (titulo: "Día 6: Por el don de Entendimiento", urlAudio: "https://tupaginaweb.com/audios/novena_dia6.m4a"),
        (titulo: "Día 7: Por el don de Sabiduría", urlAudio: "https://tupaginaweb.com/audios/novena_dia7.m4a"),
        (titulo: "Día 8: Por los frutos del Espíritu Santo", urlAudio: "https://tupaginaweb.com/audios/novena_dia8.m4a"),
        (titulo: "Día 9: Por los siete dones", urlAudio: "https://tupaginaweb.com/audios/novena_dia9.m4a")
    ]

    var body: some View {
        List {
            Section {
                Button(action: {
                    if playerManager.isPlaying {
                        playerManager.detenerAudio()
                    } else {
                        playerManager.reproducirAudio(nombreArchivo: "rosariovirgencita", extensionArchivo: "m4a")
                    }
                }) {
                    HStack(spacing: 15) {
                        Image(systemName: playerManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .foregroundColor(.purple)
                            .font(.title2)
                        
                        Text(playerManager.isPlaying ? "Pausar Rosario" : "Escuchar Rosario")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 8)
                }
            } header: {
                Text("Rosario a la Virgencita ✝️")
            }
            //nuevo
            Section {
                Button(action: {
                    if playerManager.isPlaying {
                        playerManager.detenerAudio()
                    } else {
                        playerManager.reproducirAudio(nombreArchivo: "rosario", extensionArchivo: "m4a")
                    }
                }) {
                    HStack(spacing: 15) {
                        Image(systemName: playerManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .foregroundColor(.purple)
                            .font(.title2)
                        
                        Text(playerManager.isPlaying ? "Pausar Rosario" : "Escuchar Rosario")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 8)
                }
            } header: {
                Text("Rosario al señor de la misericordia ✝️")
            }
            Section {
                DisclosureGroup(
                    isExpanded: $isNovenaExpanded,
                    content: {
                        ForEach(audiosNovena, id: \.urlAudio) { item in
                            Button(action: {
                                playerManager.reproducirAudioDesdeURL(urlString: item.urlAudio)
                            }) {
                                HStack {
                                    Image(systemName: "cloud.fill")
                                        .foregroundColor(.orange)
                                    
                                    Text(item.titulo)
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 6)
                            }
                        }
                    },
                    label: {
                        HStack(spacing: 15) {
                            Image(systemName: "flame.fill")
                                .foregroundColor(.orange)
                                .font(.title2)
                            
                            Text("Novena al Espíritu Santo")
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 8)
                    }
                )
            } header: {
                Text("Devociones y Novenas 🕊️")
            }
            
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Santo Rosario y Novena ✝️")
    }
}
#Preview {
   
    rosario()
}

 
