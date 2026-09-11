//dios
//  diosvirgencitaApp.swift
//  diosvirgencita
//virgencia y san jose
//santos de dios
//  Created by Havit on 03/07/26.
//

import SwiftUI

@main
struct diosvirgencitaApp: App {
    // 1. Aquí se inicializan las notificaciones al abrir la app
       init() {
            NotificationManager.instance.solicitarPermiso()
            
            NotificationManager.instance.programarNotificacionDiaria(
                titulo: "Versículo del Día 📖",
                cuerpo: "«Pero los que confían en el Señor renovarán sus fuerzas; levantarán el vuelo como las águilas...» (Is 40:31)",
                hora: 7,
                minuto: 0
            )
        }
       
   
    var body: some Scene {
        WindowGroup {
            VirgencitaPantallaView()
            //ContentView()
            
        }
    }
}
