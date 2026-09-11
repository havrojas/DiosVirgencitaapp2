//dios
//  bibliaView.swift
//  diosvirgencita
//
//  Created by Havit on 20/07/26.
//

import SwiftUI
// bibliaView.swift
//
//  bibliaView.swift
//  Santa Biblia Premium
//
//  Creado para Havit - Edición Premium ✝️
//
//
//  bibliaView.swift
//  Santa Biblia RVR1960 - Edición Premium ✝️
//


internal import Combine
// bibleLoader.swift
//
//  bibliaView.swift
//  Santa Biblia RVR1960 - Edición Premium ✝️
//
struct bibliaView: View {
    @StateObject private var loader = BibleLoader()
    @State private var searchText = ""
    @State private var testamentoSeleccionado = "Todos"
    
    

    let opcionesTestamento = ["Todos", "Antiguo Testamento", "Nuevo Testamento"]

    var librosFiltrados: [Libro] {
        loader.libros.filter { libro in
            let coincideTestamento = (testamentoSeleccionado == "Todos") || (libro.testamento == testamentoSeleccionado)
            let coincideBusqueda = searchText.isEmpty || libro.nombre.localizedCaseInsensitiveContains(searchText)
            return coincideTestamento && coincideBusqueda
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if loader.isLoading {
                    Spacer()
                    ProgressView("Cargando la Santa Biblia...")
                        .padding()
                    Spacer()
                } else if let errorMsg = loader.errorMessage {
                    Spacer()
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                        Text(errorMsg)
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    }
                    Spacer()
                } else {
                    Picker("Testamento", selection: $testamentoSeleccionado) {
                        ForEach(opcionesTestamento, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()

                    List(librosFiltrados) { libro in
                        NavigationLink(destination: DetalleCapitulosbibliaview(libro: libro)) {
                            HStack {
                                Image(systemName: "book.closed.fill")
                                    .foregroundColor(libro.testamento == "Nuevo Testamento" ? .blue : .brown)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(libro.nombre)
                                        .font(.headline)
                                    Text(libro.testamento)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Text("\(libro.capitulos.count) cap.")
                                    .font(.caption2)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.secondary.opacity(0.15))
                                    .cornerRadius(8)
                            }
                            .padding(.vertical, 2)
                        }
                    }
                    .listStyle(.insetGrouped)
                    .searchable(text: $searchText, prompt: "Buscar libro...")
                }
            }
            .navigationTitle("La Santa Biblia ✝️")
        }
    }
}

// Vista de Capítulos
struct DetalleCapitulosbibliaview: View {
    let libro: Libro
    let columns = [GridItem(.adaptive(minimum: 55))]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(libro.capitulos) { capitulo in
                    NavigationLink(destination: LecturaVersiculosView(libroNombre: libro.nombre, capitulo: capitulo)) {
                        Text("\(capitulo.numero)")
                            .font(.headline)
                            .frame(width: 55, height: 55)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(libro.nombre)
    }
}

// Vista de Versículos
struct LecturaVersiculosView: View {
    let libroNombre: String
    let capitulo: Capitulo
    
    // Variables de estado
    @State private var mostrarModalNota = false
    @State private var textoNuevaNota = ""
    @State private var misNotas: [String] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // 1. DESPLIEGUE DE VERSÍCULOS
                ForEach(capitulo.versiculos) { versiculo in
                    HStack(alignment: .top, spacing: 8) {
                        Text("\(versiculo.numero)")
                            .font(.caption.bold())
                            .foregroundColor(.purple)
                        
                        Text(versiculo.texto)
                            .font(.body)
                    }
                    .padding(.horizontal)
                }
                
                Divider()
                    .padding(.horizontal)
                    .padding(.top, 10)

                // 2. ⬇️ BOTÓN SIEMPRE VISIBLE (COLOR LLAMATIVO) ⬇️
                Button(action: {
                    mostrarModalNota = true
                }) {
                    HStack {
                        Image(systemName: "note.text.badge.plus")
                            .font(.title3)
                        Text("Agregar Notita / Reflexión")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple) // Color morado visible
                    .cornerRadius(14)
                    .shadow(color: Color.purple.opacity(0.3), radius: 4, x: 0, y: 2)
                }
                .padding(.horizontal)

                // 3. SECCIÓN DE NOTAS GUARDADAS
                if !misNotas.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Mis Reflexiones:")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        ForEach(misNotas, id: \.self) { nota in
                            HStack(alignment: .top, spacing: 10) {
                                Image(systemName: "sticky.note.fill")
                                    .foregroundColor(.orange)
                                Text(nota)
                                    .font(.subheadline)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.yellow.opacity(0.15))
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("\(libroNombre) \(capitulo.numero)")
        .sheet(isPresented: $mostrarModalNota) {
            NavigationView {
                Form {
                    Section(header: Text("Escribe tu reflexión o comentario")) {
                        TextEditor(text: $textoNuevaNota)
                            .frame(height: 150)
                    }
                }
                .navigationTitle("Nueva Notita")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") { mostrarModalNota = false }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Guardar") {
                            if !textoNuevaNota.isEmpty {
                                misNotas.append(textoNuevaNota)
                                textoNuevaNota = ""
                                mostrarModalNota = false
                            }
                        }
                        .bold()
                    }
                }
            }
        }
    }
}
#Preview {
    bibliaView()
}
/*var body: some View {
    ScrollView {
        VStack(alignment: .leading, spacing: 14) {
            Text("Capítulo \(capitulo.numero)")
                .font(.title)
                .bold()
                .padding(.bottom, 6)

            ForEach(capitulo.versiculos) { versiculo in
                HStack(alignment: .top, spacing: 10) {
                    Text("\(versiculo.numero)")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.blue)
                        .frame(width: 22, alignment: .trailing)
                        .padding(.top, 2)

                    Text(versiculo.texto)
                        .font(.body)
                }
            }
        }
        .padding()
    }
    .navigationTitle("\(libroNombre) \(capitulo.numero)")
}
*/
