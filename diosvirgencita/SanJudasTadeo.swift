//dios
//virgencita y san jose
//dios sus arcangeles y santos
//  SanJudasTadeo.swift
//  diosvirgencita
//
//  Created by Havit on 18/08/26.
//

import SwiftUI

// MARK: - Modelo de Oración
struct OracionSanJudas: Identifiable {
    let id = UUID()
    let titulo: String
    let contenido: String
    let subtitulo: String?
}

// MARK: - Vista Principal de San Judas Tadeo
struct SanJudasTadeoView: View {
    
    
    let oraciones: [OracionSanJudas] = [
        OracionSanJudas(
            titulo: "Oración para Casos Difíciles e Imposibles",
            contenido: """
            ¡Oh glorioso Apóstol San Judas Tadeo!, siervo fiel y amigo de Jesús, el nombre del traidor ha sido la causa de que fuiste olvidado por muchos, pero la Iglesia te honra y te invoca universalmente como el patrón de los casos difíciles e desesperados.
            
            Ruega por mí que soy tan miserable; haz uso, te ruego, de ese privilegio especial a ti concedido de socorrer pronto y visiblemente cuando casi se ha perdido toda esperanza.
            
            Ven en mi ayuda en esta gran necesidad para que reciba los consuelos y el socorro del cielo en todas mis necesidades, tribulaciones y sufrimientos, particularmente (hágase aquí la petición), y para que pueda alabar a Dios contigo y con todos los escogidos por toda la eternidad.
            
            Te prometo, glorioso San Judas, acordarme siempre de este gran favor y nunca dejar de honrarte como mi especial y poderoso protector, y hacer todo lo que pueda para fomentar tu devoción. Amén.
            """,
            subtitulo: "Patrón de los Casos Desesperados"
        ),
        OracionSanJudas(
            titulo: "Oración de Agradecimiento",
            contenido: """
            San Judas Tadeo, glorioso Apóstol, vengo ante ti con un corazón lleno de gratitud. Te doy gracias por tu constante intercesión ante nuestro Señor Jesucristo y por escuchar mis súplicas en los momentos de mayor angustia.
            
            Gracias por tu ayuda pronta y compasiva. Prometo difundir tu devoción y recordar siempre que, por la gracia de Dios y tu poderosa intercesión, hallé consuelo y esperanza. Mantén mi fe viva y ayúdame a caminar siempre en la luz de Cristo. Amén.
            """,
            subtitulo: "Por favores recibidos"
        ),
        OracionSanJudas(
            titulo: "Oración por el Trabajo y la Familia",
            contenido: """
            San Judas Tadeo, intercesor en toda necesidad difícil, te pido que mires con bondad a mi familia y mi hogar. Bendice nuestro trabajo, concédenos el sustento diario y aleja de nosotros toda carencia y angustia.
            
            Que en nuestra casa reine la paz, la salud y la armonía. Dame la fuerza para superar las dificultades laborales y financieras, y enséñame a confiar siempre en la Providencia Divina. Protege a mis seres queridos bajo tu constante amparo. Amén.
            """,
            subtitulo: "Protección y Sustento"
        ),
        OracionSanJudas(
            titulo: "Jaculatoria a San Judas Tadeo",
            contenido: """
            ¡San Judas Tadeo, glorioso Apóstol, convierte nuestras penas en gozo y ruega por nosotros y por todos los que invocan tu auxilio! Amén.
            """,
            subtitulo: nil
        )
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // MARK: - Encabezado
                    VStack(spacing: 8) {
                        Image(systemName: "flame.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.green) // El color representativo de San Juditas
                            .padding(.top, 10)
                        
                        Text("San Judas Tadeo")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("«Patrón de los casos difíciles e imposibles»")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 10)
                    
                    // MARK: - Lista de Tarjetas
                    ForEach(oraciones) { oracion in
                        TarjetaOracionSanJudasView(oracion: oracion)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("San Judas Tadeo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
            }
        }
    }
}

// MARK: - Tarjeta Reutilizable
struct TarjetaOracionSanJudasView: View {
    let oracion: OracionSanJudas
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            VStack(alignment: .leading, spacing: 4) {
                Text(oracion.titulo)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.1, green: 0.5, blue: 0.2)) // Verde San Judas
                
                if let subtitulo = oracion.subtitulo {
                    Text(subtitulo)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
            }
            
            Divider()
            
            Text(oracion.contenido)
                .font(.body)
                .foregroundColor(.primary)
                .lineSpacing(4)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Preview para Xcode
#Preview {
    SanJudasTadeoView()
}
