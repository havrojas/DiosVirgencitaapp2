//dios
//voirgencita y san jose
//sngeles y santos de dios
//  librosview.swift
//  diosvirgencita
//
//  Created by Havit on 03/08/26.
//

import SwiftUI
// 1. Modelo de datos para un Libro
struct LibroCristian: Identifiable {
    var id = UUID()
    var titulo: String
    var autor: String
    var imagenNombre: String
    var urlLectura: String
}

// 2. Vista principal de la biblioteca
struct librosview: View {
    // Lista de libros
    let libros: [LibroCristian] = [
        LibroCristian(
            titulo: "La Biblia Sagrada",
            autor: "Palabra de Dios",
            imagenNombre: "book.fill",
            urlLectura: "https://www.bible.com/es/bible/149/GEN.1.RVR1960"
        ),
        LibroCristian(
            titulo: "Imitación de Cristo",
            autor: "Tomás de Kempis",
            imagenNombre: "book.closed.fill",
            urlLectura: "https://web.seducoahuila.gob.mx/biblioweb/upload/Kempis,%20Tomas%20A.%20-%20Imitacion%20de%20Cristo.pdf"
        ),
        LibroCristian(
            titulo: "El Progreso del Peregrino",
            autor: "John Bunyan",
            imagenNombre: "books.vertical.fill",
            urlLectura: "https://www.gutenberg.org/files/131/131-h/131-h.htm"
        ),
        LibroCristian(
            titulo: "Las Confesiones",
            autor: "San Agustín",
            imagenNombre: "heart.text.square.fill",
            urlLectura: "https://www.vatican.va/spirit/documents/spirit_20001027_agostino_sp.html"
        ),
        LibroCristian(
            titulo: "El Combate Espiritual",
            autor: "Lorenzo Scúpoli",
            imagenNombre: "shield.checkered",
            urlLectura: "https://teatinos.org/wp-content/uploads/2018/08/Combate-Espiritual-Lorenzo-Scupoli-C.R..pdf"
        ),
        LibroCristian(
            titulo: "Historia de un Alma",
            autor: "Santa Teresita del Niño Jesús",
            imagenNombre: "rose.fill",
            urlLectura: "https://www.vatican.va/spirit/documents/spirit_20001110_teresa-gesu_sp.html"
        ),
        LibroCristian(
            titulo: "Camino de Perfección",
            autor: "Santa Teresa de Jesús",
            imagenNombre: "cross.fill",
            urlLectura: "https://www.vatican.va/spirit/documents/spirit_20000811_teresa-jesus_sp.html"
        )
        ]
       
                
               
                

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(libros) { libro in
                        NavigationLink(destination: DetalleLecturaLibroView(libro: libro)) {
                            VStack(alignment: .center, spacing: 10) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.purple.opacity(0.1))
                                        .frame(height: 140)
                                    
                                    Image(systemName: libro.imagenNombre)
                                        .font(.system(size: 50))
                                        .foregroundColor(.purple)
                                }

                                VStack(spacing: 4) {
                                    Text(libro.titulo)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)

                                    Text(libro.autor)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        }
                    }
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("Libros Cristianos 📚✝️")
        }
    }
}

// 3. Pantalla de lectura
struct DetalleLecturaLibroView: View {
    let libro: LibroCristian

    var body: some View {
        VStack {
            webview4(urlString: libro.urlLectura)
        }
        .navigationTitle(libro.titulo)
        .navigationBarTitleDisplayMode(.inline)
    }
}

        

#Preview {
    librosview()
}
