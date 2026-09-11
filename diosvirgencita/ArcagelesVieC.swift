//dios
//virgencita y san jose
//dios y sus arcangeles y santos
//  ArcagelesVieC.swift
//  diosvirgencita
//
//  Created by Havit on 18/08/26.
//
import SwiftUI

// MARK: - Modelo de Arcángel
struct Arcangel: Identifiable {
    let id = UUID()
    let nombre: String
    let oracion: String
    let color: Color
    let mision: String
}

// MARK: - Vista Principal de Arcángeles
struct ArcangelesView: View {
    var onVolverAlMenu: () -> Void = {}
    
    let arcangeles: [Arcangel] = [
        Arcangel(
            nombre: "San Miguel Arcángel",
            oracion: """
            San Miguel Arcángel, defiéndenos en la lucha.
            Sé nuestro amparo contra la perversidad y asechanzas del demonio.
            Que Dios manifieste sobre él su poder, es nuestra humilde súplica.
            Y tú, oh Príncipe de la Milicia Celestial, con el poder que Dios te ha conferido, arroja al infierno a Satanás, y a los demás espíritus malignos que vagan por el mundo para la perdición de las almas. Amén.
            """,
            color: .blue,
            mision: "Príncipe de la Milicia Celestial"
        ),
        Arcangel(
            nombre: "San Gabriel Arcángel",
            oracion: """
            ¡Arcángel Gabriel: embajador de Dios Padre, mensajero de la esperanza, santo Ángel del Señor!
            
            Sé tú el mensajero del milagro que espero, sé tú el que solucione mis tristezas y amarguras.
            
            Trae hasta mí el amor de mi padre el Señor nuestro Dios, para que alivie mis carencias sentimentales, mis necesidades físicas y materiales, para prodigarme la compasión del Señor. Amén.
            """,
            color: .cyan,
            mision: "Mensajero de la Esperanza"
        ),
        Arcangel(
            nombre: "San Rafael Arcángel",
            oracion: """
            Glorioso Arcángel San Rafael, medicina de Dios, guíanos en el camino de la salvación, ayúdanos en las necesidades, haz felices nuestros hogares y danos la visión de Dios en el cielo.
            
            Señor, que diste a tu hijo Tobías como compañero de viaje al Arcángel Rafael, concédenos la gracia de estar siempre protegidos por su custodia y asistidos por sus auxilios. Por Jesucristo Nuestro Señor, que vive y reina por siempre. Amén.
            """,
            color: .green,
            mision: "Medicina de Dios"
        ),
        Arcangel(
            nombre: "San Jofiel Arcángel",
            oracion: """
            ¡Oh! Sabio, radiante, esplendente, Amado Arcángel Jofiel, nuestras mentes y corazones están ávidos de penetrar en los laberintos insondables, misteriosos de la sublime ciencia del conocimiento de la Divinidad, de la potestad del espíritu del Señor Dios que nos creó, que nos guía y nos ama desde la cuna al ataúd.
            
            Tú, amadísimo Arcángel Jofiel, ilumina nuestra senda con la luz de la eterna Sabiduría, líbranos de la amenaza de la duda y la incomprensión, nutre nuestro espíritu con el pan de la iluminación espiritual y haz que sepamos amar a nuestros semejantes. Amén.
            """,
            color: .yellow,
            mision: "Luz de la Eterna Sabiduría"
        ),
        Arcangel(
            nombre: "San Zadquiel Arcángel",
            oracion: """
            ¡Oh! Señor Dios, acudimos confiados a Tu Divina Potestad para que nos concedas a Tu Amado Arcángel Zadquiel, y así sea la bendita transmutación de todo mal en bien para nuestra vida, nuestra familia y nuestro mundo.
            
            Amado Arcángel Zadquiel, te pedimos envuelvas nuestro ser con tu manto morado transmutador para disolver todo patrón negativo, falta de perdón y todo obstáculo que impida nuestro progreso espiritual. Gracias por tu amor y asistencia constante. Amén.
            """,
            color: .purple,
            mision: "Ángel de la Transmutación y Perdón"
        ),
        Arcangel(
            nombre: "San Uriel Arcángel",
            oracion: """
            ¡Oh! Dios que con inefable providencia te dignas enviar a tus santos Ángeles para nuestra custodia, concede a tus suplicantes ser siempre defendidos por su protección y gozar eternamente de su compañía.
            
            Amado Arcángel Uriel, conéctanos con la abundancia divina, llena nuestras vidas de paz, prosperidad y sabiduría celestial. Que tu fuego divino purifique nuestros pensamientos y guía nuestros pasos hacia la Providencia Divina. Por Jesucristo Nuestro Señor. Amén.
            """,
            color: .orange,
            mision: "Fuego Divino y Abundancia"
        )
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // MARK: - Encabezado
                    VStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.yellow)
                            .padding(.top, 10)
                        
                        Text("Los 7 Arcángeles")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("«Protectores, Guías y Mensajeros Celestiales»")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 10)
                    
                    // MARK: - Lista de Arcángeles
                    ForEach(arcangeles) { arcangel in
                        TarjetaArcangelView(arcangel: arcangel)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Santos Arcángeles")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        onVolverAlMenu()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Atrás")
                        }
                        .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

// MARK: - Componente Tarjeta de Arcángel
struct TarjetaArcangelView: View {
    let arcangel: Arcangel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(arcangel.nombre)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(arcangel.color)
                    
                    Text(arcangel.mision)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
                Spacer()
                
                Circle()
                    .fill(arcangel.color.opacity(0.2))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "shield.fill")
                            .font(.system(size: 14))
                            .foregroundColor(arcangel.color)
                    )
            }
            
            Divider()
            
            Text(arcangel.oracion)
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

// MARK: - Preview
#Preview {
    ArcangelesView()
}
