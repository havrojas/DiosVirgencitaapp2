//dios
//  PlanesLecturaView.swift
//  diosvirgencita
//
//  Created by Havit on 23/07/26.
//
/*
import SwiftUI
internal import Combine
//
//  PlanesLecturaView.swift
//  Santa Biblia Premium ✝️
//
//
//  PlanesLecturaView.swift
//  Santa Biblia Premium ✝️
//

 // <--- 1. CORREGIDO: Importante para ObservableObject y @StateObject

// MARK: - Modelos para Planes de Lectura
struct PlanDeLectura: Identifiable {
    let id = UUID()
    let titulo: String
    let descripcion: String
    let categoria: String
    let diasTotales: Int
    let icono: String
    var pasajesPorDia: [LecturaDiaria] // <--- 2. CORREGIDO: Cambiado de 'let' a 'var' para permitir modificar 'completado'
}

struct LecturaDiaria: Identifiable {
    let id = UUID()
    let dia: Int
    let titulo: String
    let citaBiblica: String // Ej: "Salmos 23:1-6"
    let devocionalTexto: String
    var completado: Bool = false
}

// MARK: - Manager de Progreso
class PlanesManager: ObservableObject {
    @Published var planes: [PlanDeLectura] = [
        PlanDeLectura(
            titulo: "Paz en la Ansiedad",
            descripcion: "7 días para descansar tu corazón en las promesas de Dios.",
            categoria: "Emociones",
            diasTotales: 7,
            icono: "heart.text.square.fill",
            pasajesPorDia: [
                LecturaDiaria(dia: 1, titulo: "Echa tu carga sobre Él", citaBiblica: "1 Pedro 5:6-7", devocionalTexto: "Dios se preocupa sinceramente por ti. No lleves tus cargas solo."),
                LecturaDiaria(dia: 2, titulo: "La Paz que sobrepasa entendimiento", citaBiblica: "Filipenses 4:6-7", devocionalTexto: "Presenta tus peticiones con oración y acción de gracias."),
                LecturaDiaria(dia: 3, titulo: "No temas, Él está contigo", citaBiblica: "Isaías 41:10", devocionalTexto: "Dios te sostiene con la diestra de su justicia.")
            ]
        ),
        PlanDeLectura(
            titulo: "Sabiduría Diaria (Proverbios)",
            descripcion: "Un capítulo de Proverbios al día para caminar con prudencia.",
            categoria: "Crecimiento",
            diasTotales: 31,
            icono: "book.closed.fill",
            pasajesPorDia: [
                LecturaDiaria(dia: 1, titulo: "El principio de la sabiduría", citaBiblica: "Proverbios 1:1-7", devocionalTexto: "El temor del Señor es el principio del conocimiento.")
            ]
        ),
        PlanDeLectura(
            titulo: "Los Evangelios en 30 Días",
            descripcion: "Conoce la vida, milagros y enseñanzas de Jesús de cerca.",
            categoria: "Jesús",
            diasTotales: 30,
            icono: "cross.fill",
            pasajesPorDia: [
                LecturaDiaria(dia: 1, titulo: "El Verbo se hizo carne", citaBiblica: "San Juan 1:1-14", devocionalTexto: "En el principio era el Verbo, y la luz resplandece en las tinieblas.")
            ]
        )
    ]
}

// MARK: - Vista Principal de Planes
struct PlanesLecturaView: View {
    @StateObject private var manager = PlanesManager()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Banner Motivacional
                    VStack(alignment: .leading, spacing: 8) {
                        Text("CRECE EN SU PALABRA ✝️")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                        
                        Text("Planes de Lectura")
                            .font(.title)
                            .bold()
                        
                        Text("Selecciona un plan para mantener la constancia en tu devoción diaria.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)

                    // Lista de Planes
                    ForEach(manager.planes) { plan in
                        NavigationLink(destination: DetallePlanView(plan: plan)) {
                            TarjetaPlanView(plan: plan)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Planes 📖")
        }
    }
}

// MARK: - Tarjeta de Plan Individual
struct TarjetaPlanView: View {
    let plan: PlanDeLectura
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: plan.icono)
                .font(.largeTitle)
                .foregroundColor(.orange)
                .frame(width: 60, height: 60)
                .background(Color.orange.opacity(0.15))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(plan.categoria.uppercased())
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                
                Text(plan.titulo)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(plan.descripcion)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                    Image(systemName: "calendar")
                        .font(.caption)
                    Text("\(plan.diasTotales) días")
                        .font(.caption)
                        .bold()
                }
                .foregroundColor(.orange)
                .padding(.top, 2)
            }
            Spacer()
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(16)
    }
}

// MARK: - Vista Detalle del Plan
struct DetallePlanView: View {
    @State var plan: PlanDeLectura
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(plan.titulo)
                        .font(.title2)
                        .bold()
                    
                    Text(plan.descripcion)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()

                Divider()

                Text("Lecturas Diarias")
                    .font(.headline)
                    .padding(.horizontal)

                ForEach($plan.pasajesPorDia) { $lectura in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Día \(lectura.dia): \(lectura.titulo)")
                                .font(.headline)
                            Spacer()
                            Button(action: {
                                lectura.completado.toggle()
                            }) {
                                Image(systemName: lectura.completado ? "checkmark.circle.fill" : "circle")
                                    .font(.title2)
                                    .foregroundColor(lectura.completado ? .green : .gray)
                            }
                        }
                        
                        Text(lectura.citaBiblica)
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.orange)
                        
                        Text(lectura.devocionalTexto)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(lectura.completado ? Color.green.opacity(0.08) : Color(UIColor.tertiarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Detalle del Plan")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PlanesLecturaView()
}
*/
//
//  PlanesLecturaView.swift
//  Santa Biblia Premium ✝️
//

/*import SwiftUI
internal import Combine

// MARK: - Modelos de Datos Expandidos
struct PlanDeLectura: Identifiable {
    let id = UUID()
    let titulo: String
    let descripcion: String
    let categoria: String
    let diasTotales: Int
    let icono: String
    var pasajesPorDia: [LecturaDiaria]
}

struct LecturaDiaria: Identifiable {
    let id = UUID()
    let dia: Int
    let titulo: String
    let citaBiblica: String // Ej: "1 Pedro 5:6-7"
    let textoVersiculo: String // El pasaje bíblico completo
    let devocionalTexto: String // La reflexión profunda
    let oracionDelDia: String // Oración para concluir
    var completado: Bool = false
}

// MARK: - Manager de Planes
class PlanesManager: ObservableObject {
    @Published var planes: [PlanDeLectura] = [
        PlanDeLectura(
            titulo: "Paz en la Ansiedad",
            descripcion: "7 días para descansar tu corazón en las promesas de Dios.",
            categoria: "Emociones",
            diasTotales: 7,
            icono: "heart.text.square.fill",
            pasajesPorDia: [
                LecturaDiaria(
                    dia: 1,
                    titulo: "Echa tu carga sobre Él",
                    citaBiblica: "1 Pedro 5:6-7",
                    textoVersiculo: "Humillaos, pues, bajo la poderosa mano de Dios, para que él os exalte cuando fuere tiempo; echando toda vuestra ansiedad sobre él, porque él tiene cuidado de vosotros.",
                    devocionalTexto: "Muchas veces intentamos llevar las cargas de la vida con nuestras propias fuerzas. Sin embargo, Dios nos invita a rendir nuestras inquietudes ante Su presencia. Reconocer que necesitamos Su ayuda no es señal de debilidad, sino de fe. Él no solo escucha tus preocupaciones, sino que se interesa activamente en cada detalle de tu vida.",
                    oracionDelDia: "Señor Jesús, hoy te entrego mis cargas y mis afanes. Reconozco que no puedo con todo solo. Gracias porque sé que tú cuidas de mí y tienes el control de mi vida. Amén. ✝️"
                ),
                LecturaDiaria(
                    dia: 2,
                    titulo: "La Paz que sobrepasa entendimiento",
                    citaBiblica: "Filipenses 4:6-7",
                    textoVersiculo: "Por nada estéis afanosos, sino sean conocidas vuestras peticiones delante de Dios en toda oración y ruego, con acción de gracias. Y la paz de Dios, que sobrepasa todo entendimiento, guardará vuestros corazones y vuestros pensamientos en Cristo Jesús.",
                    devocionalTexto: "La paz que Dios ofrece no depende de las circunstancias externas. Es una tranquilidad profunda que guarda nuestro corazón aun en medio de la tormenta. Cuando sientas que la ansiedad quiere dominarte, transforma esa preocupación en una oración llena de gratitud.",
                    oracionDelDia: "Padre Celestial, te pido que guardes mi corazón y mi mente hoy. Cambio mis inquietudes por tu paz inexplicable. En el nombre de Jesús, Amén."
                )
            ]
        ),
        PlanDeLectura(
            titulo: "Sabiduría Diaria (Proverbios)",
            descripcion: "Camina con prudencia y toma decisiones guiadas por Dios.",
            categoria: "Crecimiento",
            diasTotales: 31,
            icono: "book.closed.fill",
            pasajesPorDia: [
                LecturaDiaria(
                    dia: 1,
                    titulo: "El principio de la sabiduría",
                    citaBiblica: "Proverbios 1:1-7",
                    textoVersiculo: "El principio de la sabiduría es el temor del Señor; los insensatos desprecian la sabiduría y la enseñanza.",
                    devocionalTexto: "El 'temor del Señor' no significa tenerle miedo a Dios, sino respetarle, honrarle y reconocer Su soberanía sobre nuestras vidas. Cuando ponemos a Dios en el primer lugar de nuestras decisiones, todo lo demás adquiere el orden correcto.",
                    oracionDelDia: "Señor, dame un corazón enseñable y sabio para tomar las decisiones correctas en el día de hoy. Amén."
                )
            ]
        )
    ]
}

// MARK: - Vista Principal de Planes
struct PlanesLecturaView: View {
    @StateObject private var manager = PlanesManager()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Encabezado
                    VStack(alignment: .leading, spacing: 6) {
                        Text("CRECE EN SU PALABRA ✝️")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                        
                        Text("Planes de Lectura")
                            .font(.title)
                            .bold()
                        
                        Text("Selecciona un plan para ver sus lecturas y reflexiones diarias.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)

                    // Lista de Planes
                    ForEach(manager.planes) { plan in
                        NavigationLink(destination: DetallePlanView(plan: plan)) {
                            TarjetaPlanView(plan: plan)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Planes 📖")
        }
    }
}

// MARK: - Tarjeta de Plan Individual
struct TarjetaPlanView: View {
    let plan: PlanDeLectura
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: plan.icono)
                .font(.largeTitle)
                .foregroundColor(.orange)
                .frame(width: 60, height: 60)
                .background(Color.orange.opacity(0.15))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(plan.categoria.uppercased())
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                
                Text(plan.titulo)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(plan.descripcion)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(16)
    }
}

// MARK: - Lista de Días del Plan
struct DetallePlanView: View {
    @State var plan: PlanDeLectura
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(plan.titulo)
                        .font(.title2)
                        .bold()
                    
                    Text(plan.descripcion)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()

                Divider()

                Text("Toca un día para leer más información 📖")
                    .font(.headline)
                    .padding(.horizontal)

                ForEach($plan.pasajesPorDia) { $lectura in
                    NavigationLink(destination: LecturaDetalleView(lectura: $lectura)) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Día \(lectura.dia): \(lectura.titulo)")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text(lectura.citaBiblica)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.orange)
                            }
                            Spacer()
                            
                            Image(systemName: lectura.completado ? "checkmark.circle.fill" : "circle")
                                .font(.title2)
                                .foregroundColor(lectura.completado ? .green : .gray)
                        }
                        .padding()
                        .background(lectura.completado ? Color.green.opacity(0.08) : Color(UIColor.tertiarySystemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle("Días de Lectura")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Pantalla de Información Completa del Día ✝️
struct LecturaDetalleView: View {
    @Binding var lectura: LecturaDiaria

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Título y Día
                VStack(alignment: .leading, spacing: 6) {
                    Text("DÍA \(lectura.dia)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.orange.opacity(0.2))
                        .foregroundColor(.orange)
                        .cornerRadius(8)

                    Text(lectura.titulo)
                        .font(.title)
                        .bold()
                }

                // Cita y Versículo Completo
                VStack(alignment: .leading, spacing: 10) {
                    Text(lectura.citaBiblica)
                        .font(.headline)
                        .foregroundColor(.orange)

                    Text("“\(lectura.textoVersiculo)”")
                        .font(.body)
                        .italic()
                        .lineSpacing(4)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.orange.opacity(0.08))
                        .cornerRadius(12)
                }

                // Reflexión Devocional
                VStack(alignment: .leading, spacing: 8) {
                    Label("Reflexión del día", systemImage: "text.quote")
                        .font(.headline)

                    Text(lectura.devocionalTexto)
                        .font(.body)
                        .lineSpacing(5)
                        .foregroundColor(.secondary)
                }

                // Oración Final
                VStack(alignment: .leading, spacing: 8) {
                    Label("Oración", systemImage: "hands.sparkles.fill")
                        .font(.headline)
                        .foregroundColor(.brown)

                    Text(lectura.oracionDelDia)
                        .font(.subheadline)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.brown.opacity(0.1))
                        .cornerRadius(12)
                }

                // Botón para marcar como completado
                Button(action: {
                    lectura.completado.toggle()
                }) {
                    HStack {
                        Image(systemName: lectura.completado ? "checkmark.circle.fill" : "circle")
                        Text(lectura.completado ? "Completado ✝️" : "Marcar Día como Leído")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(lectura.completado ? Color.green : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(14)
                }
                .padding(.top, 10)
            }
            .padding()
        }
        .navigationTitle(lectura.citaBiblica)
        .navigationBarTitleDisplayMode(.inline)
    }
}
*/
//
//  dios
//PlanesLecturaView.swift
//  Santa Biblia Premium ✝️
//

import SwiftUI
internal import Combine

// MARK: - Modelos de Datos
struct PlanDeLectura: Identifiable {
    let id = UUID()
    let titulo: String
    let descripcion: String
    let categoria: String
    let diasTotales: Int
    let icono: String
    var pasajesPorDia: [LecturaDiaria]
}

struct LecturaDiaria: Identifiable {
    let id = UUID()
    let dia: Int
    let titulo: String
    let citaBiblica: String
    let textoVersiculo: String
    let devocionalTexto: String
    let oracionDelDia: String
    var completado: Bool = false
}

// MARK: - Manager con Generador de Días Completo
class PlanesManager: ObservableObject {
    @Published var planes: [PlanDeLectura] = []

    init() {
        cargarPlanes()
    }

    func cargarPlanes() {
        self.planes = [
            // PLAN 1: PAZ EN LA ANSIEDAD (7 DÍAS COMPLETOS)
            PlanDeLectura(
                titulo: "Paz en la Ansiedad",
                descripcion: "7 días para descansar tu corazón en las promesas de Dios.",
                categoria: "Emociones",
                diasTotales: 7,
                icono: "heart.text.square.fill",
                pasajesPorDia: generarPlanAnsiedad()
            ),
            
            // PLAN 2: PROVERBIOS (31 DÍAS COMPLETOS)
            PlanDeLectura(
                titulo: "Sabiduría Diaria (Proverbios)",
                descripcion: "31 días recorriendo un capítulo de Proverbios al día.",
                categoria: "Crecimiento",
                diasTotales: 31,
                icono: "book.closed.fill",
                pasajesPorDia: generarPlanProverbios31Dias()
            )
        ]
    }

    // Generador de los 7 Días de Ansiedad
    private func generarPlanAnsiedad() -> [LecturaDiaria] {
        let citas = [
            ("1 Pedro 5:6-7", "Echa tu carga sobre Él", "Humillaos, pues, bajo la poderosa mano de Dios...", "Entrega tus cargas a Dios."),
            ("Filipenses 4:6-7", "La Paz sobrepasa entendimiento", "Por nada estéis afanosos...", "Cambia la preocupación por oración."),
            ("Isaías 41:10", "No temas, Él está contigo", "No temas, porque yo estoy contigo; no desmayes...", "Dios te sostiene con su diestra."),
            ("Salmos 23:1-6", "El Señor es mi Pastor", "Jehová es mi pastor; nada me faltará...", "En lugares de delicados pastos me hará descansar."),
            ("Mateo 6:25-34", "El afán y la ansiedad", "No os afanéis por vuestra vida, qué habéis de comer...", "Busca primeramente el reino de Dios."),
            ("Salmos 46:1-3", "Dios es nuestro amparo", "Dios es nuestro amparo y fortaleza, nuestro pronto auxilio...", "Él es tu refugio en la tribulación."),
            ("Juan 14:27", "La paz os dejo", "La paz os dejo, mi paz os doy; yo no os la doy como el mundo la da...", "Jesús te deja su paz inexplicable.")
        ]

        return citas.enumerated().map { (index, item) in
            LecturaDiaria(
                dia: index + 1,
                titulo: item.1,
                citaBiblica: item.0,
                textoVersiculo: item.2,
                devocionalTexto: item.3,
                oracionDelDia: "Señor Jesús, te entrego mi día y recibo tu paz en el corazón. Amén. ✝️"
            )
        }
    }

    // Generador de los 31 Días de Proverbios
    private func generarPlanProverbios31Dias() -> [LecturaDiaria] {
        var lecturas: [LecturaDiaria] = []
        for dia in 1...31 {
            lecturas.append(
                LecturaDiaria(
                    dia: dia,
                    titulo: "Sabiduría para el día \(dia)",
                    citaBiblica: "Proverbios Capítulo \(dia)",
                    textoVersiculo: "Lee hoy el capítulo \(dia) completo del libro de Proverbios para recibir la guía de Dios.",
                    devocionalTexto: "Medita en cómo aplicar las enseñanzas de Proverbios \(dia) a tus decisiones cotidianas, tus palabras y tus relaciones.",
                    oracionDelDia: "Padre Celestial, dame la sabiduría de Proverbios capítulo \(dia) para conducirme con prudencia e integridad hoy. Amén. ✝️"
                )
            )
        }
        return lecturas
    }
}

// MARK: - Vista Principal
struct PlanesLecturaView: View {
    @StateObject private var manager = PlanesManager()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("CRECE EN SU PALABRA ✝️")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                        
                        Text("Planes de Lectura")
                            .font(.title)
                            .bold()
                        
                        Text("Selecciona un plan completo para tu devoción diaria.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)

                    ForEach(manager.planes) { plan in
                        NavigationLink(destination: DetallePlanView(plan: plan)) {
                            TarjetaPlanView(plan: plan)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Planes 📖")
        }
    }
}

// MARK: - Tarjeta de Plan
struct TarjetaPlanView: View {
    let plan: PlanDeLectura
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: plan.icono)
                .font(.largeTitle)
                .foregroundColor(.orange)
                .frame(width: 60, height: 60)
                .background(Color.orange.opacity(0.15))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(plan.categoria.uppercased())
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                
                Text(plan.titulo)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("\(plan.diasTotales) Días de Lectura")
                    .font(.subheadline)
                    .foregroundColor(.orange)
                    .bold()
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(16)
    }
}

// MARK: - Lista de Días (Muestra 1 a 31 completos)
struct DetallePlanView: View {
    @State var plan: PlanDeLectura
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(plan.titulo)
                        .font(.title2)
                        .bold()
                    
                    Text(plan.descripcion)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()

                Divider()

                Text("Días del Plan (\(plan.pasajesPorDia.count) días)")
                    .font(.headline)
                    .padding(.horizontal)

                ForEach($plan.pasajesPorDia) { $lectura in
                    NavigationLink(destination: LecturaDetalleView(lectura: $lectura)) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Día \(lectura.dia): \(lectura.titulo)")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text(lectura.citaBiblica)
                                    .font(.subheadline)
                                    .foregroundColor(.orange)
                            }
                            Spacer()
                            
                            Image(systemName: lectura.completado ? "checkmark.circle.fill" : "circle")
                                .font(.title2)
                                .foregroundColor(lectura.completado ? .green : .gray)
                        }
                        .padding()
                        .background(lectura.completado ? Color.green.opacity(0.08) : Color(UIColor.tertiarySystemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle("Lista de Días")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Pantalla de Detalle de Lectura
struct LecturaDetalleView: View {
    @Binding var lectura: LecturaDiaria

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("DÍA \(lectura.dia)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.orange.opacity(0.2))
                        .foregroundColor(.orange)
                        .cornerRadius(8)

                    Text(lectura.titulo)
                        .font(.title)
                        .bold()
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text(lectura.citaBiblica)
                        .font(.headline)
                        .foregroundColor(.orange)

                    Text("“\(lectura.textoVersiculo)”")
                        .font(.body)
                        .italic()
                        .lineSpacing(4)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.orange.opacity(0.08))
                        .cornerRadius(12)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Label("Reflexión", systemImage: "text.quote")
                        .font(.headline)

                    Text(lectura.devocionalTexto)
                        .font(.body)
                        .foregroundColor(.secondary)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Label("Oración", systemImage: "hands.sparkles.fill")
                        .font(.headline)
                        .foregroundColor(.brown)

                    Text(lectura.oracionDelDia)
                        .font(.subheadline)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.brown.opacity(0.1))
                        .cornerRadius(12)
                }

                Button(action: {
                    lectura.completado.toggle()
                }) {
                    HStack {
                        Image(systemName: lectura.completado ? "checkmark.circle.fill" : "circle")
                        Text(lectura.completado ? "Completado ✝️" : "Marcar como Leído")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(lectura.completado ? Color.green : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(14)
                }
                .padding(.top, 10)
            }
            .padding()
        }
        .navigationTitle(lectura.citaBiblica)
        .navigationBarTitleDisplayMode(.inline)
    }
}
