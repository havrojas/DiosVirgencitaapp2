//dios
//virgencita y san jose
//dios arcangeles y santos
//  SanJoseView.swift
//  diosvirgencita
//
//  Created by Havit on 17/08/26.
//
import SwiftUI

// MARK: - Modelo de Oración
struct OracionSanJose: Identifiable {
    let id = UUID()
    let titulo: String
    let contenido: String
    let autorOFuente: String?
}

// MARK: - Vista Principal de San José
struct SanJoseView: View {
    
    
    // Lista de oraciones cargadas
    let oraciones: [OracionSanJose] = [
        OracionSanJose(
            titulo: "Salve, Custodio del Redentor",
            contenido: """
            Salve, custodio del Redentor
            y esposo de la Virgen María.
            A ti Dios confió a su Hijo,
            en ti María depositó su confianza,
            contigo Cristo se forjó como hombre.
            
            Oh, bienaventurado José,
            muéstrate padre también a nosotros
            y guíanos en el camino de la vida.
            
            Concédenos gracia, misericordia y valentía,
            y defiéndenos de todo mal. Amén.
            """,
            autorOFuente: "Papa Francisco, Patris Corde"
        ),
        OracionSanJose(
            titulo: "Consagración a San José",
            contenido: """
            José dulcísimo y Padre amantísimo de mi corazón, a ti te elijo como mi protector en vida y en muerte; y consagro a tu culto este día, en recompensa y satisfacción de los muchos que vanamente he dado al mundo, y a sus vanísimas vanidades.
            
            Yo te suplico con todo mi corazón que por tus siete dolores y goces me alcances de tu adoptivo Hijo Jesús y de tu verdadera esposa, María Santísima, la gracia de emplearlos a mucha honra y gloria suya, y en bien y provecho de mi alma.
            
            Alcánzame vivas luces para conocer la gravedad de mis culpas, lágrimas de contrición para llorarlas y detestarlas, propósitos firmes para no cometerlas más, fortaleza para resistir a las tentaciones, perseverancia para seguir el camino de la virtud; particularmente lo que te pido en esta oración (hágase aquí la petición) y una cristiana disposición para morir bien.
            
            Esto es, Santo mío, lo que te suplico; y esto es lo que mediante tu poderosa intercesión, espero alcanzar de mi Dios y Señor, a quien deseo amar y servir, como tú lo amaste y serviste siempre, por siempre, y por una eternidad. Amén.
            """,
            autorOFuente: nil
        ),
        OracionSanJose(
            titulo: "Oración para Todos los Días",
            contenido: """
            ¡Glorioso Patriarca San José!, animado de una gran confianza en vuestro gran valimiento, a Vos acudo para que seáis mi protector durante los días de mi destierro en este valle de lágrimas.
            
            Vuestra altísima dignidad de Padre putativo de mi amante Jesús hace que nada se os niegue de cuanto pidáis en el cielo. Sed mi abogado, especialísimamente en la hora de mi muerte, y alcanzadme la gracia de que mi alma, cuando se desprenda de la carne, vaya a descansar en las manos del Señor. Amén.
            
            Jaculatoria: Bondadoso San José, Esposo de María, protegednos; defended a la Iglesia y al Sumo Pontífice y amparad a mis parientes, amigos y bienhechores.
            """,
            autorOFuente: nil
        ),
        OracionSanJose(
            titulo: "Visita a San José",
            contenido: """
            ¡Oh castísimo esposo de la Virgen María, mi amantísimo protector San José! Todo el que implora vuestra protección experimenta vuestro consuelo. Sed, pues, Vos mi amparo y mi guía. Pedid al Señor por mí; libradme del pecado, socorredme en las tentaciones y apartadme del mal y del pecado.
            
            Consoladme en las enfermedades y aflicciones. Sean mis pensamientos, palabras y obras fiel trasunto de cuanto os pueda ser acepto y agradable para merecer dignamente vuestro amparo en la vida y en la hora de la muerte. Amén.
            
            Jaculatoria: ¡Oh glorioso San José! Haced que sea constante en el bien; corregid mis faltas y alcanzadme el perdón de mis pecados.
            """,
            autorOFuente: nil
        )
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // MARK: - Encabezado
                    VStack(spacing: 8) {
                        Image(systemName: "person.crop.circle.badge.checkmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.purple)
                            .padding(.top, 10)
                        
                        Text("San José")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("«Custodio del Redentor y Patrono de la Iglesia»")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 10)
                    
                    // MARK: - Tarjetas de Oraciones
                    ForEach(oraciones) { oracion in
                        TarjetaOracionView(oracion: oracion)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("San José")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
            }
        }
    }
}

// MARK: - Componente Reutilizable de Tarjeta
struct TarjetaOracionView: View {
    let oracion: OracionSanJose
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(oracion.titulo)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.purple)
            
            Text(oracion.contenido)
                .font(.body)
                .foregroundColor(.primary)
                .lineSpacing(4)
            
            if let fuente = oracion.autorOFuente {
                Text("— \(fuente)")
                    .font(.caption)
                    .italic()
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    SanJoseView()
}
