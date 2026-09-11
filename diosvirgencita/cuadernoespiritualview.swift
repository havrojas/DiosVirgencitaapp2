//dios
//virgen maria y san jose
//angeles de dios y santos de dios
//  cuadernoespiritualview.swift
//  diosvirgencita
//
//  Created by Havit on 02/08/26.
//

import SwiftUI
struct NotaDiario: Identifiable, Codable {
    var id = UUID()
    var titulo: String
    var contenido: String
    var fecha: String
}

struct cuadernoespiritualview: View {
    // Guardar las notas de forma permanente en el dispositivo
    @AppStorage("notas_diario_data") private var notasData: Data = Data()
    @State private var listaNotas: [NotaDiario] = []
    
    @State private var mostrarModalNuevaNota = false
    @State private var nuevoTitulo = ""
    @State private var nuevoContenido = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()

                if listaNotas.isEmpty {
                    // Vista cuando no hay notas aún
                    VStack(spacing: 16) {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 60))
                            .foregroundColor(.purple.opacity(0.6))

                        Text("Tu Cuaderno de Oraciones y Fe")
                            .font(.title3.bold())

                        Text("Usa este espacio como tu diario personal para anotar tus reflexiones, peticiones a Dios y agradecimientos.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)

                        Button(action: {
                            mostrarModalNuevaNota = true
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                Text("Escribir mi primera nota")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(12)
                        }
                        .padding(.top, 10)
                    }
                } else {
                    // Lista de notas redactadas
                    List {
                        ForEach(listaNotas) { nota in
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text(nota.titulo)
                                        .font(.headline)
                                        .foregroundColor(.purple)
                                    Spacer()
                                    Text(nota.fecha)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }

                                Text(nota.contenido)
                                    .font(.body)
                                    .foregroundColor(.primary)
                                    .lineLimit(4)
                            }
                            .padding(.vertical, 6)
                        }
                        .onDelete(perform: borrarNota)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle("Diario Espiritual ✝️")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        mostrarModalNuevaNota = true
                    }) {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.purple)
                    }
                }
            }
            .sheet(isPresented: $mostrarModalNuevaNota) {
                NavigationView {
                    Form {
                        Section(header: Text("Título")) {
                            TextField("Ej. Oración por mi familia, Reflexión...", text: $nuevoTitulo)
                        }

                        Section(header: Text("Escribe tus notas / reflexiones")) {
                            TextEditor(text: $nuevoContenido)
                                .frame(minHeight: 200)
                        }
                    }
                    .navigationTitle("Nueva Anotación")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancelar") {
                                limpiarCampos()
                                mostrarModalNuevaNota = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Guardar") {
                                guardarNuevaNota()
                            }
                            .bold()
                            .disabled(nuevoContenido.isEmpty)
                        }
                    }
                }
            }
            .onAppear {
                cargarNotas()
            }
        }
    }

    // MARK: - Funciones para Guardar y Cargar Datos
    private func guardarNuevaNota() {
        let fechaActual = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
        let tituloFinal = nuevoTitulo.isEmpty ? "Anotación de Fe" : nuevoTitulo
        
        let nuevaNota = NotaDiario(
            titulo: tituloFinal,
            contenido: nuevoContenido,
            fecha: fechaActual
        )

        listaNotas.insert(nuevaNota, at: 0)
        guardarEnStorage()
        limpiarCampos()
        mostrarModalNuevaNota = false
    }

    private func borrarNota(at offsets: IndexSet) {
        listaNotas.remove(atOffsets: offsets)
        guardarEnStorage()
    }

    private func guardarEnStorage() {
        if let encoded = try? JSONEncoder().encode(listaNotas) {
            notasData = encoded
        }
    }

    private func cargarNotas() {
        if let decoded = try? JSONDecoder().decode([NotaDiario].self, from: notasData) {
            listaNotas = decoded
        }
    }

    private func limpiarCampos() {
        nuevoTitulo = ""
        nuevoContenido = ""
    }
}

#Preview {
   cuadernoespiritualview()
}


