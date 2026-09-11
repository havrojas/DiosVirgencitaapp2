//dios
//virgencita y san jose
//santos y angeles de dios
//  AudioPlayerManager.swift
//  diosvirgencita
//
//  Created by Havit on 31/07/26.
//
import Foundation
import AVFoundation
internal import Combine

class AudioPlayerManager: ObservableObject {

    
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying: Bool = false

    func reproducirAudio(nombreArchivo: String, extensionArchivo: String = "m4a") {
        // Busca el archivo que subiste al proyecto
        guard let url = Bundle.main.url(forResource: nombreArchivo, withExtension: extensionArchivo) else {
            print("⚠️ No se encontró el archivo de audio: \(nombreArchivo).\(extensionArchivo)")
            return
        }

        do {
            // Configura la sesión de audio para que se escuche claro
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("Error al reproducir el audio: \(error.localizedDescription)")
        }
    }

    func detenerAudio() {
        audioPlayer?.stop()
        isPlaying = false
    }
}
