//dios
//virgencita maria y san jose
//santos y angeles de dios
//  ntificationmanager.swift
//  diosvirgencita
//
//  Created by Havit on 02/08/26.
//

import SwiftUI
import Foundation
    import UserNotifications

    class NotificationManager {
        static let instance = NotificationManager() // Singleton

        // 1. Solicitar permisos al usuario al abrir la app
        func solicitarPermiso() {
            let options: UNAuthorizationOptions = [.alert, .sound, .badge]
            UNUserNotificationCenter.current().requestAuthorization(options: options) { concedido, error in
                if let error = error {
                    print("Error al solicitar permiso: \(error.localizedDescription)")
                } else if concedido {
                    print("Permisos de notificaciones concedidos ✝️")
                } else {
                    print("El usuario denegó las notificaciones")
                }
            }
        }

        // 2. Programar Notificación Diaria (ej. Versículo del Día a las 8:00 AM)
        func programarNotificacionDiaria(titulo: String, cuerpo: String, hora: Int, minuto: Int) {
            let contenido = UNMutableNotificationContent()
            contenido.title = titulo
            contenido.body = cuerpo
            contenido.sound = .default

            // Configurar la hora exacta de disparo
            var dateComponents = DateComponents()
            dateComponents.hour = hora
            dateComponents.minute = minuto

            // Trigger repetitivo cada día
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            // Crear la petición con un identificador único
            let request = UNNotificationRequest(
                identifier: "notificacion_diaria_\(hora)_\(minuto)",
                content: contenido,
                trigger: trigger
            )

            // Registrar en iOS
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error al programar notificación: \(error.localizedDescription)")
                } else {
                    print("Notificación programada con éxito para las \(hora):\(minuto)")
                }
            }
        }
    }

