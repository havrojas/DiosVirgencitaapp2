//dios
//virgencita y san jose
//angeles y santos de dios
//  oracioescategoriasview.swift
//  diosvirgencita
//
//  Created by Havit on 31/07/26.
//

import SwiftUI
struct CategoriaOracion: Identifiable {
    let id = UUID()
    let titulo: String
    let icono: String
    let color: Color
    let oraciones: [OracionItem]
}

struct OracionItem: Identifiable {
    let id = UUID()
    let titulo: String
    let contenido: String
    let citaBiblica: String?
}

struct OracionesCategoriasView: View {
    @State private var categoriaSeleccionada: CategoriaOracion?

    let categorias: [CategoriaOracion] = [
        CategoriaOracion(
            titulo: "Al Comenzar el Día",
            icono: "sun.max.fill",
            color: .orange,
            oraciones: [
                OracionItem(
                    titulo: "Ofrecimiento de la Mañana",
                    contenido: "Señor, en el silencio de este día que nace, vengo a pedirte paz, sabiduría y fuerza. Quiero mirar hoy el mundo con ojos llenos de amor, ser paciente, comprensivo, humilde y bueno. Cierra mis oídos a toda calumnia, guarda mi lengua de toda maldad y llena mi espíritu de bendición.",
                    citaBiblica: "Salmo 5:3"
                )
            ]
        ),
        CategoriaOracion(
            titulo: "Al Ir a Descansar",
            icono: "moon.stars.fill",
            color: .indigo,
            oraciones: [
                OracionItem(
                    titulo: "Oración de la Noche",
                    contenido: "Padre bueno, al terminar este día te doy gracias por tus bendiciones. Perdona mis faltas de hoy y dale descanso a mi mente y cuerpo. Pongo en tus manos a mi familia y mi hogar. En paz me acostaré y asimismo me dormiré, porque solo Tú me haces vivir confiado.",
                    citaBiblica: "Salmo 4:8"
                )
            ]
        ),
        CategoriaOracion(
            titulo: "Paz y Ansiedad",
            icono: "heart.hand.fill",
            color: .teal,
            oraciones: [
                OracionItem(
                    titulo: "En Momentos de Inquietud",
                    contenido: "Jesús mío, entrego en tus manos mis preocupaciones, temores y la prisa de mi corazón. Tú dijiste 'no se turbe vuestro corazón'. Dame tu paz que sobrepasa todo entendimiento y hazme confiar en que Tú tienes el control de mi vida.",
                    citaBiblica: "Filipenses 4:6-7"
                )
            ]
        ),
        CategoriaOracion(
            titulo: "Alimentos y Gratitud",
            icono: "fork.knife",
            color: .green,
            oraciones: [
                OracionItem(
                    titulo: "Bendición de la Mesa",
                    contenido: "Bendice, Señor, estos alimentos que por tu bondad vamos a tomar. Bendice las manos que los prepararon y da pan a los que tienen hambre y hambre de Ti a los que tienen pan. Te lo pedimos por Cristo nuestro Señor. Amén.",
                    citaBiblica: "1 Timoteo 4:4-5"
                )
            ]
        ),
        CategoriaOracion(
            titulo: "Salud y Sanación",
            icono: "cross.case.fill",
            color: .blue,
            oraciones: [
                OracionItem(
                    titulo: "Oración por los Enfermos",
                    contenido: "Señor Jesús, Médico de las almas y de los cuerpos, mira con compasión a quienes sufren enfermedad. Fortalece su fe, renueva su ánimo y concede la gracia de la sanación según tu santísima voluntad. Sé Tú su alivio y fortaleza.",
                    citaBiblica: "Jeremías 17:14"
                )
            ]
        )
    ]


        var body: some View {
            NavigationView {
                ScrollView {
                    VStack(spacing: 16) {
                        
                        // Banner devocional
                        VStack(spacing: 6) {
                            Image(systemName: "book.pages.fill")
                                .font(.system(size: 38))
                                .foregroundColor(.purple)
                                .padding(.top, 10)

                            Text("Momentos de Oración")
                                .font(.title2.bold())

                            Text("«Oren en todo momento en el Espíritu con toda oración y ruego.» (Ef 6, 18)")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding(.bottom, 10)

                        // Grid de categorías
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                            ForEach(categorias) { cat in
                                Button(action: {
                                    categoriaSeleccionada = cat
                                }) {
                                    VStack(alignment: .leading, spacing: 12) {
                                        ZStack {
                                            Circle()
                                                .fill(cat.color.opacity(0.15))
                                                .frame(width: 44, height: 44)
                                            Image(systemName: cat.icono)
                                                .font(.title3)
                                                .foregroundColor(cat.color)
                                        }

                                        Text(cat.titulo)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                            .multilineTextAlignment(.leading)

                                        Text("\(cat.oraciones.count) oraciones")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(UIColor.secondarySystemGroupedBackground))
                                    .cornerRadius(16)
                                    .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .navigationTitle("Oraciones por Momento")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(item: $categoriaSeleccionada) { cat in
                    DetalleCategoriaView(categoria: cat)
                }
            }
        }
    }

    // Vista de detalle cuando abren una categoría
    struct DetalleCategoriaView: View {
        let categoria: CategoriaOracion
        @Environment(\.dismiss) var dismiss

        var body: some View {
            NavigationView {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(categoria.oraciones) { oracion in
                            VStack(alignment: .leading, spacing: 12) {
                                Text(oracion.titulo)
                                    .font(.title3.bold())
                                    .foregroundColor(categoria.color)

                                if let cita = oracion.citaBiblica {
                                    Text(cita)
                                        .font(.caption.bold())
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(categoria.color.opacity(0.12))
                                        .foregroundColor(categoria.color)
                                        .cornerRadius(6)
                                }

                                Text(oracion.contenido)
                                    .font(.body)
                                    .lineSpacing(5)
                                    .foregroundColor(.primary)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
                        }
                    }
                    .padding()
                }
                .navigationTitle(categoria.titulo)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Cerrar") { dismiss() }
                    }
                }
            }
        }
    }
#Preview {
    OracionesCategoriasView()
}
