//dios
//virgencita y san jose
//dios sus angeles y santos y patriarcas
//  peticionesview.swift
//  diosvirgencita
//
//  Created by Havit on 31/07/26.
//
import SwiftUI
struct peticionesview: View {
    @State private var mostrarweb6 = false
        @State private var peticiones: [Peticion] = [
            Peticion(nombre: "María G.", motivo: "Pido oración por la salud de mi mamá que está en el hospital.", fecha: "Hoy", oracionesCount: 12),
            Peticion(nombre: "Juan C.", motivo: "Oración para encontrar paz y dirección en mis estudios y trabajo.", fecha: "Ayer", oracionesCount: 8),
            Peticion(nombre: "Familia R.", motivo: "Damos gracias a Dios por una bendición recibida y pedimos protección.", fecha: "Hace 2 días", oracionesCount: 25)
        ]
        
        @State private var mostrarModalAgregar = false
        @State private var nuevoNombre = ""
        @State private var nuevoMotivo = ""

        var body: some View {
            NavigationView {
                ZStack {
                    Color(UIColor.systemGroupedBackground)
                        .ignoresSafeArea()

                    ScrollView {
                        VStack(spacing: 16) {
                            
                            // Encabezado devocional
                            VStack(spacing: 6) {
                                Image(systemName: "hands.sparkles.fill")
                                    .font(.system(size: 36))
                                    .foregroundColor(.purple)
                                    .padding(.top, 10)

                                Text("Unidos en Oración")
                                    .font(.title.bold())

                                Text("«Donde dos o tres se reúnen en mi nombre, allí estoy yo en medio de ellos.» (Mt 18, 20)")
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 20)
                            }
                            .padding(.bottom, 10)

                            // Lista de tarjetas de petición
                            ForEach(peticiones.indices, id: \.self) { index in
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack {
                                        Text(peticiones[index].nombre)
                                            .font(.headline)
                                            .foregroundColor(.purple)

                                        Spacer()

                                        Text(peticiones[index].fecha)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }

                                    Text(peticiones[index].motivo)
                                        .font(.body)
                                        .foregroundColor(.primary)

                                    Divider()

                                    HStack {
                                        Button(action: {
                                            withAnimation {
                                                if !peticiones[index].yaOro {
                                                    peticiones[index].oracionesCount += 1
                                                    peticiones[index].yaOro = true
                                                } else {
                                                    peticiones[index].oracionesCount -= 1
                                                    peticiones[index].yaOro = false
                                                }
                                            }
                                        }) {
                                            HStack(spacing: 6) {
                                                Image(systemName: peticiones[index].yaOro ? "heart.fill" : "heart")
                                                    .foregroundColor(peticiones[index].yaOro ? .red : .purple)
                                                Text(peticiones[index].yaOro ? "Unido en oración" : "Me uno en oración")
                                                    .font(.subheadline.bold())
                                                    .foregroundColor(peticiones[index].yaOro ? .red : .purple)
                                            }
                                        }

                                        Spacer()

                                        Text("🤲 \(peticiones[index].oracionesCount) orando")
                                            .font(.caption.bold())
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding()
                                .background(Color(UIColor.secondarySystemGroupedBackground))
                                .cornerRadius(16)
                                .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 80)
                    }

                    // Botón Flotante para agregar nueva petición
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                mostrarModalAgregar = true
                            }) {
                                HStack {
                                    Image(systemName: "plus")
                                    Text("Pedir Oración")
                                }
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 14)
                                .background(Color.purple)
                                .cornerRadius(30)
                                .shadow(color: Color.purple.opacity(0.4), radius: 8, x: 0, y: 4)
                                // Botón Flotante para agregar nueva petición
                                HStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                          mostrarweb6 = true
                                        }) {
                                            HStack {
                                                Image(systemName: "plus")
                                                Text("Pedir Oración online")
                                            }
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 4)
                                            .background(Color.purple)
                                            .cornerRadius(30)
                                            .shadow(color: Color.purple.opacity(0.4), radius: 8, x: 0, y: 4)
                                        }
                                        
                                    }
                                    .sheet(isPresented: $mostrarweb6){
                                        web6()
                                    }
                                }
                            }
                            .padding(.trailing, 20)
                            .padding(.bottom, 20)
                        }
                    }
                }
                .navigationTitle("Peticiones")
                .navigationBarTitleDisplayMode(.inline)
                // Modal para escribir intención
                .sheet(isPresented: $mostrarModalAgregar) {
                    NavigationView {
                        Form {
                            Section(header: Text("Tu Nombre o Iniciales")) {
                                TextField("Ej. Havit R. o Anónimo", text: $nuevoNombre)
                            }

                            Section(header: Text("Intención de Oración")) {
                                TextEditor(text: $nuevoMotivo)
                                    .frame(height: 120)
                            }
                        }
                        .navigationTitle("Nueva Petición")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancelar") { mostrarModalAgregar = false }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Publicar") {
                                    if !nuevoMotivo.isEmpty {
                                        let nueva = Peticion(
                                            nombre: nuevoNombre.isEmpty ? "Anónimo" : nuevoNombre,
                                            motivo: nuevoMotivo,
                                            fecha: "Hoy",
                                            oracionesCount: 1
                                        )
                                        peticiones.insert(nueva, at: 0)
                                        nuevoNombre = ""
                                        nuevoMotivo = ""
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

#Preview {
    peticionesview()
}
