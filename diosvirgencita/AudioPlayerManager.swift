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
/*
class AudioPlayerManager: ObservableObject {

    
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying: Bool = false

    func reproducirAudio(nombreAudio: String, extensionAudio: String = "m4a") {
        // Busca el archivo que subiste al proyecto
        guard let url = Bundle.main.url(forResource: nombreAudio, withExtension: extensionAudio) else {
            print("⚠️ No se encontró el archivo de audio: \(nombreAudio).\(extensionAudio)")
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
*/
class AudioPlayerManager: ObservableObject {
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying: Bool = false
    
    // Función para reproducir desde la nube por URL
    func reproducirAudioDesdeURL(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("❌ URL no válida")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            let soundData = try Data(contentsOf: url)
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("❌ Error al reproducir: \(error.localizedDescription)")
        }
    }
    
    // Función para reproducir local (por si la usas en otra parte)
    func reproducirAudio(nombreArchivo: String, extensionArchivo: String) {
        guard let url = Bundle.main.url(forResource: nombreArchivo, withExtension: extensionArchivo) else {
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("Error")
        }
    }
    
    func detenerAudio() {
        audioPlayer?.stop()
        isPlaying = false
    }
}
