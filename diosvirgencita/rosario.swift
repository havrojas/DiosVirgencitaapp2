//dios
//virgencita y san jose
//dios sus angeles y santos
//  rosario.swift
//  diosvirgencita
//
//  Created by Havit on 31/07/26.
//

import SwiftUI

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
                        Text(playerManager.isPlaying ? "Pausar" : "Escuchar mi voz")
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
