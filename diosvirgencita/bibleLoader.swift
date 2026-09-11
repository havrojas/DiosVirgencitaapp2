//dios
//  bibleLoader.swift
//  diosvirgencita
//
//  Created by Havit on 20/07/26.
//
import Foundation
//dios
// bibleLoader.swift
// diosvirgencita
import SwiftUI // 👈 Esto quita los 3 errores rojos
internal import Combine
//dios
// bibleLoader.swift
// diosvirgencita
// Modelos de datos para SwiftUI
// bibleLoader.swift
// bibleLoader.swift
struct Versiculo: Identifiable, Hashable {
    var id: Int { numero }
    let numero: Int
    let texto: String
}

struct Capitulo: Identifiable, Hashable {
    var id: Int { numero }
    let numero: Int
    let versiculos: [Versiculo]
}

struct Libro: Identifiable, Hashable {
    var id: String { nombre }
    let nombre: String
    let testamento: String
    let capitulos: [Capitulo]
}

class BibleLoader: ObservableObject {
    @Published var libros: [Libro] = []
    @Published var isLoading = true
    @Published var errorMessage: String? = nil

    // Orden canónico de los 66 libros de la Biblia
    private let ordenBiblia: [String] = [
        // Antiguo Testamento
        "Génesis", "Éxodo", "Levítico", "Números", "Deuteronomio",
        "Josué", "Jueces", "Rut", "1 Samuel", "2 Samuel",
        "1 Reyes", "2 Reyes", "1 Crónicas", "2 Crónicas", "Esdras",
        "Nehemías", "Ester", "Job", "Salmos", "Proverbios",
        "Eclesiastés", "Cantares", "Isaías", "Jeremías", "Lamentaciones",
        "Ezequiel", "Daniel", "Oseas", "Joel", "Amós",
        "Abdías", "Jonás", "Miqueas", "Nahúm", "Habacuc",
        "Sofonías", "Hageo", "Zacarías", "Malaquías",
        
        // Nuevo Testamento
        "Mateo", "Marcos", "Lucas", "Juan", "Hechos",
        "Romanos", "1 Corintios", "2 Corintios", "Gálatas", "Efesios",
        "Filipenses", "Colosenses", "1 Tesalonicenses", "2 Tesalonicenses",
        "1 Timoteo", "2 Timoteo", "Tito", "Filemón", "Hebreos",
        "Santiago", "1 Pedro", "2 Pedro", "1 Juan", "2 Juan",
        "3 Juan", "Judas", "Apocalipsis"
    ]

    init() {
        cargarBibliaLocal()
    }

    func cargarBibliaLocal() {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let url = Bundle.main.url(forResource: "RVR1960 - Spanish", withExtension: "json") else {
                DispatchQueue.main.async {
                    self.errorMessage = "⚠️ No se encontró el archivo RVR1960 - Spanish.json."
                    self.isLoading = false
                }
                return
            }

            do {
                let data = try Data(contentsOf: url)
                
                guard let rawDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    DispatchQueue.main.async {
                        self.errorMessage = "⚠️ El archivo no tiene un formato válido."
                        self.isLoading = false
                    }
                    return
                }

                var listaLibros: [Libro] = []

                for (nombreLibro, capValue) in rawDict {
                    guard let dicCapitulos = capValue as? [String: Any] else { continue }
                    
                    var listaCapitulos: [Capitulo] = []
                    let capsOrdenados = dicCapitulos.keys.compactMap { Int($0) }.sorted()

                    for numCap in capsOrdenados {
                        if let dicVersiculos = dicCapitulos["\(numCap)"] as? [String: Any] {
                            var listaVersiculos: [Versiculo] = []
                            let versOrdenados = dicVersiculos.keys.compactMap { Int($0) }.sorted()

                            for numVers in versOrdenados {
                                if let textoVers = dicVersiculos["\(numVers)"] as? String {
                                    listaVersiculos.append(Versiculo(numero: numVers, texto: textoVers))
                                }
                            }

                            listaCapitulos.append(Capitulo(numero: numCap, versiculos: listaVersiculos))
                        }
                    }

                    let esNuevo = ["Mateo", "Marcos", "Lucas", "Juan", "Hechos", "Romanos", "Corintios", "Gálatas", "Efesios", "Filipenses", "Colosenses", "Tesalonicenses", "Timoteo", "Tito", "Filemón", "Hebreos", "Santiago", "Pedro", "Judas", "Apocalipsis"].contains(where: { nombreLibro.contains($0) })

                    let testamento = esNuevo ? "Nuevo Testamento" : "Antiguo Testamento"

                    listaLibros.append(Libro(nombre: nombreLibro, testamento: testamento, capitulos: listaCapitulos))
                }

                // Función de ordenamiento basada en la lista oficial
                let librosOrdenados = listaLibros.sorted { l1, l2 in
                    let idx1 = self.ordenBiblia.firstIndex(where: { l1.nombre.contains($0) }) ?? 999
                    let idx2 = self.ordenBiblia.firstIndex(where: { l2.nombre.contains($0) }) ?? 999
                    return idx1 < idx2
                }

                DispatchQueue.main.async {
                    self.libros = librosOrdenados
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "⚠️ Error al leer JSON: \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }
}
