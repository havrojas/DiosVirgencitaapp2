//dios
//virgencita y san jose
//santos y angeles de dios
//  testimonioview.swift
//  diosvirgencita
//
//  Created by Havit on 01/08/26.
//

import SwiftUI
struct TestimonioItem: Identifiable {
    let id = UUID()
    let autor: String
    let titulo: String
    let historia: String
    let fecha: String
    let esPrincipal: Bool
}

struct testimonioview: View {
    @State private var testimonios: [TestimonioItem] = [
        TestimonioItem(
            autor: "Havit Obispo Rojas",
            titulo: "De las Tinieblas a la Luz de Dios",
            historia: """
Quiero dar testimonio del amor incondicional de Dios y cómo Su presencia ha guiado cada paso de mi vida, mis proyectos y mi camino. En los momentos de prueba Su fidelidad nunca me ha faltado, y hoy dedico este esfuerzo para darle la gloria a Él.

Siempre fui cercano a Dios, pero hubo un momento que, por querer tener a una mujer, hice todo lo malo ante Dios: practiqué lectura de cartas, quise hacer amarres, consulté con brujas y llegué a leer algo hacia lo malo. Dios bendito me llamaba, pero en mi enojo me molesté con Dios porque pensé que no quería ayudarme e hice todo lo malo.

Después pasó el tiempo y tuve un sueño con lo malo; desperté asustado y Dios me ayudó a pesar de todo. Tuve ataques del mal como ira, enojo, rabia, angustia, pensamientos intrusivos y miedo a cosas que no conocía; pero Dios me ayudó, Dios me perdonó y Dios me eligió. La guerra fue más intensa, pero Dios me defendió: a cada blasfemia Dios me dio respuesta, a cada falta de fe Dios me aumentó la fe, a cada pensamiento malo Dios lo cambió. Dios me dio respuestas diciendo: «Todo es por Mí».

Dios me mostró señales de Su existencia y me dio respuestas a través de Su palabra real. Me mostró a David y me identificó con él: a David Dios le dio una estrellita y a mí me dio un pescadito, recordándome que Él gobierna desde el universo hasta el agua, para ser un hombre conforme al corazón de Dios.

Dios me ha dado muchas respuestas y señales. Él dice: «Todo es por Mí: mi casa, la empresa, las ideas, todo». Dios me ha dado salmos para el combate, me hizo ser un hombre de guerra y me mostró Su palabra real: «Lámpara es a mis pies tu palabra, y lumbrera a mi camino» (Salmo 119:105).

Dios me ha ayudado, Dios está conmigo y el mal nunca podrá contra eso. Obvio la batalla es fuerte, pero me alejé de la brujería y quité de la casa de Dios toda pulsera y cualquier cosa contraria a Él.
""",
            fecha: "Testimonio de Fe",
            esPrincipal: true
        )
    ]
    
    @State private var mostrarModalAgregar = false
    @State private var nuevoAutor = ""
    @State private var nuevoTitulo = ""
    @State private var nuevaHistoria = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        
                        // Encabezado
                        VStack(spacing: 6) {
                            Image(systemName: "quote.bubble.fill")
                                .font(.system(size: 38))
                                .foregroundColor(.purple)
                                .padding(.top, 10)

                            Text("Testimonios de Fe")
                                .font(.title2.bold())

                            Text("«Vengan a oír, y les contaré lo que Dios ha hecho por mí.» (Sal 66, 16)")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding(.bottom, 5)

                        // Lista de Testimonios
                        ForEach(testimonios) { item in
                            TarjetaTestimonioView(item: item)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 90)
                }

                // Botón Flotante
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            mostrarModalAgregar = true
                        }) {
                            HStack {
                                Image(systemName: "plus.bubble.fill")
                                Text("Compartir Testimonio")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            .background(Color.purple)
                            .cornerRadius(30)
                            .shadow(color: Color.purple.opacity(0.4), radius: 8, x: 0, y: 4)
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle("Testimonios")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $mostrarModalAgregar) {
                NavigationView {
                    Form {
                        Section(header: Text("Tu Nombre")) {
                            TextField("Ej. Hermano en Cristo", text: $nuevoAutor)
                        }

                        Section(header: Text("Título del Testimonio")) {
                            TextField("Ej. Dios estuvo conmigo", text: $nuevoTitulo)
                        }

                        Section(header: Text("Tu Historia o Testimonio")) {
                            TextEditor(text: $nuevaHistoria)
                                .frame(height: 150)
                        }
                    }
                    .navigationTitle("Nuevo Testimonio")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancelar") { mostrarModalAgregar = false }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Publicar") {
                                if !nuevaHistoria.isEmpty {
                                    let nuevo = TestimonioItem(
                                        autor: nuevoAutor.isEmpty ? "Hermano en Cristo" : nuevoAutor,
                                        titulo: nuevoTitulo.isEmpty ? "Grandeza de Dios" : nuevoTitulo,
                                        historia: nuevaHistoria,
                                        fecha: "Hoy",
                                        esPrincipal: false
                                    )
                                    testimonios.append(nuevo)
                                    nuevoAutor = ""
                                    nuevoTitulo = ""
                                    nuevaHistoria = ""
                                    mostrarModalAgregar = false
                                }
                            }
                            .bold()
                        }
                    }
                }
            }
        }
    }
}

// Subvista simplificada que evita errores del compilador
struct TarjetaTestimonioView: View {
    let item: TestimonioItem

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                if item.esPrincipal {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                        Text("Testimonio Principal")
                    }
                    .font(.caption2.bold())
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.yellow.opacity(0.2))
                    .foregroundColor(.orange)
                    .cornerRadius(8)
                } else {
                    Text(item.autor)
                        .font(.subheadline.bold())
                        .foregroundColor(.purple)
                }

                Spacer()

                Text(item.fecha)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Text(item.titulo)
                .font(.title3.bold())
                .foregroundColor(.primary)

            Text(item.historia)
                .font(.body)
                .lineSpacing(5)
                .foregroundColor(.primary)

            if item.esPrincipal {
                HStack {
                    Spacer()
                    Text("— \(item.autor)")
                        .font(.subheadline.bold())
                        .foregroundColor(.purple)
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(item.esPrincipal ? Color.purple.opacity(0.4) : Color.clear, lineWidth: 2)
        )
        .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
}


#Preview {
    testimonioview()
}


