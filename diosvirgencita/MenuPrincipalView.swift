/*import SwiftUI
import SafariServices
internal import Combine

struct MenuPrincipalView: View {
    var body: some View {
    
        ZStack {
            Color(red: 0.96, green: 0.98, blue: 1.0).ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    Text("Dios App")
                        .font(.largeTitle).bold()
                        .padding(.top, 28)

                    // Padre Nuestro
                    NavigationLink(destination: PadreNuestroStyledView()) {
                        HomeButtonLabel(title: "padre nuestro", color: Color(red: 0.93, green: 0.85, blue: 0.90))
                            .overlay(alignment: .leading) { LabelIcon(systemName: "rose") }
                    }

                    // Salmos
                    
                    if let url = URL(string: "https://sendero-fe-guia.base44.app/salmos") {
                        NavigationLink(destination: EmbeddedSafariView(url: url)) {
                            HomeButtonLabel(title: "Salmos", color: Color(red: 0.82, green: 0.90, blue: 0.82))
                                .overlay(alignment: .leading) { LabelIcon(systemName: "book.closed") }
                        }
                    }

                    // Oraciones a la Virgencita
                    NavigationLink(destination: OracionesVirgencitaView()) {
                        HomeButtonLabel(title: "A la Virgencita", color: Color(red: 0.93, green: 0.85, blue: 0.90))
                            .overlay(alignment: .leading) { LabelIcon(systemName: "rose") }
                    }
                    
                    // Virgencita con pantalla de carga
                    NavigationLink(destination: VirgencitaPantallaView()) {
                        HomeButtonLabel(title: "Virgencita (con carga)", color: Color(red: 0.93, green: 0.85, blue: 0.90))
                            .overlay(alignment: .leading) { LabelIcon(systemName: "rose") }
                    }

                    // Rosario (enlace externo)
                    if let url = URL(string: "https://opusdei.org/es-mx/article/santo-rosario-audio/") {
                        NavigationLink(destination: EmbeddedSafariView(url: url)) {
                            HomeButtonLabel(title: "Rosario", color: Color(red: 0.94, green: 0.90, blue: 0.80))
                                .overlay(alignment: .leading) { LabelIcon(systemName: "beads") }
                        }
                    }

                    // Visita al Padre (YouTube)
                    if let url = URL(string: "https://www.youtube.com/@padrehectormariosalazarlon9086") {
                        NavigationLink(destination: EmbeddedSafariView(url: url)) {
                            HomeButtonLabel(title: "Visita al Padre", color: Color(red: 0.88, green: 0.86, blue: 0.96))
                                .overlay(alignment: .leading) { LabelIcon(systemName: "building.columns") }
                                .opacity(0.98)
                        }
                    }

                    // Playlist de Dios (Apple Music)
                    if let musicURL = URL(string: "https://music.apple.com/mx/playlist/dios/pl.u-jV89b7NtDX2e53m") {
                        NavigationLink(destination: EmbeddedSafariView(url: musicURL)) {
                            HomeButtonLabel(title: "Playlist de Dios", color: Color(red: 0.75, green: 0.85, blue: 0.98))
                                .overlay(alignment: .leading) { LabelIcon(systemName: "music.note.list") }
                                .opacity(0.98)
                        }
                    }
                    //dios
                    NavigationLink(destination: bibliaView()) {
                        Label("La Santa Biblia", systemImage: "book.fill")
                    }
                    NavigationLink(destination:
    PlanesLecturaView()) {
                        Label("planes", systemImage: "book.fill")
                    }

                    
                    
                    
                    

                    Spacer(minLength: 24)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Nested helper views to avoid global redeclaration
    private struct HomeButtonLabel: View {
        var title: String
        var color: Color

        var body: some View {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(color.opacity(0.4))
                .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(color.opacity(0.5), lineWidth: 1))
                .frame(maxWidth: .infinity, minHeight: 52)
                .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                .overlay {
                    HStack {
                        Spacer().frame(width: 44)
                        Text(title)
                            .font(.headline)
                            .bold()
                            .foregroundColor(.primary)
                        Spacer()
                    }
                }
                .padding(.vertical, 6)
        }
    }

    private struct LabelIcon: View {
        var systemName: String

        var body: some View {
            Image(systemName: systemName)
                .foregroundColor(.primary)
                .font(.title2)
                .frame(width: 32, height: 32)
                .padding(.leading, 12)
        }
    }
}

// MARK: - Placeholder Views to satisfy references
fileprivate struct PadreNuestroPlaceholderView: View {
    var body: some View {
        ScrollView {
            Text("Padre Nuestro")
                .font(.title)
                .padding()
            Text("Padre nuestro, que estás en el cielo, santificado sea tu Nombre; venga a nosotros tu reino; hágase tu voluntad en la tierra como en el cielo. Danos hoy nuestro pan de cada día; perdona nuestras ofensas, como también nosotros perdonamos a los que nos ofenden; no nos dejes caer en la tentación, y líbranos del mal. Amén.")
                .padding()
        }
        .navigationTitle("Padre Nuestro")
    }
}

struct PadreNuestroStyledView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Padre Nuestro")
                    .font(.largeTitle).bold()
                    .padding(.top)

                Text(
                    "Padre nuestro, que estás en el cielo, santificado sea tu Nombre; venga a nosotros tu reino; hágase tu voluntad en la tierra como en el cielo. Danos hoy nuestro pan de cada día; perdona nuestras ofensas, como también nosotros perdonamos a los que nos ofenden; no nos dejes caer en la tentación, y líbranos del mal. Amén."
                )
                .font(.title3)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.leading)
                .lineSpacing(6)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.white.opacity(0.7))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16).stroke(Color.black.opacity(0.06), lineWidth: 1)
                        )
                )

                VStack(alignment: .leading, spacing: 8) {
                    Text("Intenciones")
                        .font(.headline)
                    Text("Ofrece esta oración por tus seres queridos y necesidades del día.")
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12).fill(Color(red: 0.93, green: 0.85, blue: 0.90).opacity(0.15))
                )

                Spacer(minLength: 24)
            }
            .padding()
        }
        .background(Color(red: 0.96, green: 0.98, blue: 1.0).ignoresSafeArea())
        .navigationTitle("Padre Nuestro")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OracionesVirgencitaView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Oraciones a la Virgencita")
                    .font(.largeTitle).bold()
                    .padding(.top)

                Group {
                    Text("Ave María")
                        .font(.title2).bold()
                    Text("Dios te salve, María, llena eres de gracia; el Señor es contigo; bendita Tú eres entre todas las mujeres, y bendito es el fruto de tu vientre, Jesús. Santa María, Madre de Dios, ruega por nosotros, pecadores, ahora y en la hora de nuestra muerte. Amén.")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14).fill(Color.white.opacity(0.75))
                        )
                }

                Group {
                    Text("Bajo tu amparo")
                        .font(.title2).bold()
                    Text("Bajo tu amparo nos acogemos, Santa Madre de Dios; no deseches las oraciones que te dirigimos en nuestras necesidades; antes bien, líbranos de todo peligro, oh siempre Virgen gloriosa y bendita.")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14).fill(Color.white.opacity(0.75))
                        )
                }

                Group {
                    Text("Salve")
                        .font(.title2).bold()
                    Text("Dios te salve, Reina y Madre de misericordia; vida, dulzura y esperanza nuestra, Dios te salve. A Ti clamamos los desterrados hijos de Eva; a Ti suspiramos, gimiendo y llorando en este valle de lágrimas. Ea, pues, Señora, abogada nuestra, vuelve a nosotros esos tus ojos misericordiosos; y después de este destierro, muéstranos a Jesús, fruto bendito de tu vientre. ¡Oh clemente, oh piadosa, oh dulce Virgen María! Ruega por nosotros, Santa Madre de Dios, para que seamos dignos de alcanzar las promesas de nuestro Señor Jesucristo. Amén.")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14).fill(Color.white.opacity(0.75))
                        )
                }

                Spacer(minLength: 24)
            }
            .padding()
        }
        .background(Color(red: 0.96, green: 0.98, blue: 1.0).ignoresSafeArea())
        .navigationTitle("Virgencita")
        .navigationBarTitleDisplayMode(.inline)
    }
}

fileprivate struct EmbeddedSafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}




#Preview {
    NavigationStack { MenuPrincipalView() }
}
*/
//dios
import SwiftUI
import SafariServices
internal import Combine

struct MenuPrincipalView: View {
    // Grid flexible de 2 columnas para organizar las secciones principales
    private let gridColumns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.98, blue: 1.0).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // MARK: - Encabezado
                    VStack(spacing: 6) {
                        Image(systemName: "cross.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.orange)
                            .padding(.bottom, 2)

                        Text("Dios App")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.primary)

                        Text("Encuentra paz en tu día a día ✝️")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)

                    // MARK: - Accesos Principales (Biblia y Planes)
                    VStack(spacing: 12) {
                        // La Santa Biblia
                        NavigationLink(destination: bibliaView()) {
                            HStack {
                                Image(systemName: "book.fill")
                                    .font(.title2)
                                Text("La Santa Biblia")
                                    .font(.headline)
                                    .bold()
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.subheadline)
                                    .bold()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(colors: [.orange, Color(red: 0.85, green: 0.55, blue: 0.20)], startPoint: .leading, endPoint: .trailing)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .shadow(color: .orange.opacity(0.3), radius: 6, x: 0, y: 3)
                        }

                        // Planes de Lectura
                        NavigationLink(destination: PlanesLecturaView()) {
                            HStack {
                                Image(systemName: "calendar.badge.clock")
                                    .font(.title2)
                                Text("Planes de Lectura")
                                    .font(.headline)
                                    .bold()
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.subheadline)
                                    .bold()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange.opacity(0.12))
                            .foregroundColor(.orange)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.orange.opacity(0.3), lineWidth: 1)
                            )
                        }
                    }

                    Divider()
                        .padding(.vertical, 4)

                    // MARK: - Cuadrícula de Devociones y Enlaces
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Devociones y Oraciones")
                            .font(.headline)
                            .foregroundColor(.secondary)

                        LazyVGrid(columns: gridColumns, spacing: 14) {
                            
                            // Padre Nuestro
                            NavigationLink(destination: PadreNuestroStyledView()) {
                                TarjetaMenuGrid(title: "Padre Nuestro", icon: "rose", color: Color(red: 0.93, green: 0.85, blue: 0.90))
                            }

                            // Salmos
                             
                                NavigationLink(destination:webview3())  {
                                    TarjetaMenuGrid(title: "Salmos", icon: "book.closed", color: Color(red: 0.82, green: 0.90, blue: 0.82))
                                }
                            

                            // Oraciones a la Virgencita
                            NavigationLink(destination: OracionesVirgencitaView()) {
                                TarjetaMenuGrid(title: "A la Virgencita", icon: "rose", color: Color(red: 0.93, green: 0.85, blue: 0.90))
                            }

                            // Virgencita con pantalla de carga
                            NavigationLink(destination: peticionesview()) {
                                TarjetaMenuGrid(title: "peticiones", icon: "sparkles", color: Color(red: 0.93, green: 0.85, blue: 0.90))
                            }

                            // Rosario (enlace externo)
                            if let url = URL(string: "https://opusdei.org/es-mx/article/santo-rosario-audio/") {
                                NavigationLink(destination: EmbeddedSafariView(url: url)) {
                                    TarjetaMenuGrid(title: "Rosario", icon: "beads", color: Color(red: 0.94, green: 0.90, blue: 0.80))
                                }
                            }

                            // Visita al Padre (YouTube)
                            if let url = URL(string: "https://www.youtube.com/@padrehectormariosalazarlon9086") {
                                NavigationLink(destination: EmbeddedSafariView(url: url)) {
                                    TarjetaMenuGrid(title: "Visita al Padre", icon: "building.columns", color: Color(red: 0.88, green: 0.86, blue: 0.96))
                                }
                            }

                            // Playlist de Dios (Apple Music)
                         
                                NavigationLink(destination:webview2()) {
                                    TarjetaMenuGrid(title: "Playlist de Dios", icon: "music.note.list", color: Color(red: 0.75, green: 0.85, blue: 0.98))
                                }
                            
                            // Consejero AI (Google Gemini)
                            NavigationLink(destination: //ConsejeroAIView
    webview5()) {
                                TarjetaMenuGrid(
                                    title: "Consejero AI",
                                    icon: "sparkles",
                                    color: .orange
                                )
                            }
                            NavigationLink(destination: RadarIglesiasView()) {
                                Text("Buscar Iglesias Cercanas 🗺️✝️")
                            }
                            NavigationLink(destination: rosario()) {
                                HStack {
                                    Image(systemName: "cross.fill")
                                        .foregroundColor(.purple)
                                    Text("Rezar el Santo Rosario")
                                        .font(.headline)
                                }
                            }
                            
                            //dios
                            NavigationLink(destination: confesionesview()) {
                                HStack {
                                    Image(systemName: "cross.vessel.fill")
                                        .foregroundColor(.purple)
                                    Text("Guía para la Confesión")
                                        .font(.headline)
                                }
                            }
                            
                            //dios
                            NavigationLink(destination: OracionesCategoriasView()) {
                                HStack {
                                    Image(systemName: "cross.vessel.fill")
                                        .foregroundColor(.purple)
                                    Text("oraciones")
                                        .font(.headline)
                                }
                            }
                            
                            NavigationLink(destination: misvideosview()) {
                                HStack {
                                    Image(systemName: "cross.vessel.fill")
                                        .foregroundColor(.purple)
                                    Text("videos")
                                        .font(.headline)
                                }
                            }
                            NavigationLink(destination: testimonioview()) {
                                HStack {
                                    Image(systemName: "quote.bubble.fill")
                                        .foregroundColor(.purple)
                                    Text("Testimonios de Fe")
                                        .font(.headline)
                                }
                            }
                            NavigationLink(destination: cuadernoespiritualview()) {
                                HStack {
                                    Image(systemName: "book.closed.fill")
                                        .foregroundColor(.purple)
                                        .font(.title2)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Diario Espiritual")
                                            .font(.headline)
                                        Text("Escribe tus reflexiones y oraciones")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(UIColor.secondarySystemGroupedBackground))
                                .cornerRadius(12)
                            }
                           // NavigationLink(destination: webview2()) {
                                //Text("🗺️✝️")
                            //}
                            Button("Probar Notificación en 5 segundos ✝️") {
                                let contenido = UNMutableNotificationContent()
                                contenido.title = "Versículo del Día 📖"
                                contenido.body = "«Pero los que confían en el Señor renovarán sus fuerzas...»"
                                contenido.sound = .default

                                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                                let request = UNNotificationRequest(identifier: "prueba_5s", content: contenido, trigger: trigger)

                                UNUserNotificationCenter.current().add(request)
                            }
                            
                            //dios
                            NavigationLink(destination: librosview()) {
                                HStack {
                                    Image(systemName: "books.vertical.fill")
                                        .foregroundColor(.purple)
                                        .font(.title2)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Biblioteca Cristiana")
                                            .font(.headline)
                                        Text("Lee libros espirituales en línea")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(UIColor.secondarySystemGroupedBackground))
                                .cornerRadius(12)
                            }
                            //dios
                            NavigationLink(destination: SanJoseView()) {
                                HStack {
                                    Image(systemName: "books.vertical.fill")
                                        .foregroundColor(.purple)
                                        .font(.title2)
                                    
                                    VStack(alignment: .leading) {
                                        Text("san jose")
                                            .font(.headline)
                                        Text("Lee libros espirituales en línea")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(UIColor.secondarySystemGroupedBackground))
                                .cornerRadius(12)
                            }
                            NavigationLink(destination: SanJudasTadeoView()) {
                                HStack {
                                    Image(systemName: "books.vertical.fill")
                                        .foregroundColor(.purple)
                                        .font(.title2)
                                    
                                    VStack(alignment: .leading) {
                                        Text("san juditas tadeo")
                                            .font(.headline)
                                        Text("Lee libros espirituales en línea")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(UIColor.secondarySystemGroupedBackground))
                                .cornerRadius(12)
                            }
                            NavigationLink(destination: ArcangelesView()) {
                                HStack {
                                    Image(systemName: "books.vertical.fill")
                                        .foregroundColor(.purple)
                                        .font(.title2)
                                    
                                    VStack(alignment: .leading) {
                                        Text("arcangeles")
                                            .font(.headline)
                                        Text("Lee libros espirituales en línea")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(UIColor.secondarySystemGroupedBackground))
                                .cornerRadius(12)
                            }
                        }
                    }

                    Spacer(minLength: 24)
                }
          
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Componente de Tarjeta para la Cuadrícula
private struct TarjetaMenuGrid: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.primary)
                .frame(width: 50, height: 50)
                .background(color.opacity(0.6))
                .clipShape(Circle())

            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.85)
        }
        .frame(maxWidth: .infinity, minHeight: 110)
        .padding(.horizontal, 8)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color.opacity(0.4), lineWidth: 1)
        )
    }
}

// MARK: - Placeholder Views
fileprivate struct PadreNuestroPlaceholderView: View {
    var body: some View {
        ScrollView {
            Text("Padre Nuestro")
                .font(.title)
                .padding()
            Text("Padre nuestro, que estás en el cielo, santificado sea tu Nombre; venga a nosotros tu reino; hágase tu voluntad en la tierra como en el cielo. Danos hoy nuestro pan de cada día; perdona nuestras ofensas, como también nosotros perdonamos a los que nos ofenden; no nos dejes caer en la tentación, y líbranos del mal. Amén.")
                .padding()
        }
        .navigationTitle("Padre Nuestro")
    }
}

struct PadreNuestroStyledView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Padre Nuestro")
                    .font(.largeTitle).bold()
                    .padding(.top)

                Text(
                    "Padre nuestro, que estás en el cielo, santificado sea tu Nombre; venga a nosotros tu reino; hágase tu voluntad en la tierra como en el cielo. Danos hoy nuestro pan de cada día; perdona nuestras ofensas, como también nosotros perdonamos a los que nos ofenden; no nos dejes caer en la tentación, y líbranos del mal. Amén."
                )
                .font(.title3)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.leading)
                .lineSpacing(6)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.white.opacity(0.7))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16).stroke(Color.black.opacity(0.06), lineWidth: 1)
                        )
                )

                VStack(alignment: .leading, spacing: 8) {
                    Text("Intenciones")
                        .font(.headline)
                    Text("Ofrece esta oración por tus seres queridos y necesidades del día.")
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12).fill(Color(red: 0.93, green: 0.85, blue: 0.90).opacity(0.15))
                )

                Spacer(minLength: 24)
            }
            .padding()
        }
        .background(Color(red: 0.96, green: 0.98, blue: 1.0).ignoresSafeArea())
        .navigationTitle("Padre Nuestro")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OracionesVirgencitaView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Oraciones a la Virgencita")
                    .font(.largeTitle).bold()
                    .padding(.top)

                Group {
                    Text("Ave María")
                        .font(.title2).bold()
                    Text("Dios te salve, María, llena eres de gracia; el Señor es contigo; bendita Tú eres entre todas las mujeres, y bendito es el fruto de tu vientre, Jesús. Santa María, Madre de Dios, ruega por nosotros, pecadores, ahora y en la hora de nuestra muerte. Amén.")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14).fill(Color.white.opacity(0.75))
                        )
                }

                Group {
                    Text("Bajo tu amparo")
                        .font(.title2).bold()
                    Text("Bajo tu amparo nos acogemos, Santa Madre de Dios; no deseches las oraciones que te dirigimos en nuestras necesidades; antes bien, líbranos de todo peligro, oh siempre Virgen gloriosa y bendita.")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14).fill(Color.white.opacity(0.75))
                        )
                }

                Group {
                    Text("Salve")
                        .font(.title2).bold()
                    Text("Dios te salve, Reina y Madre de misericordia; vida, dulzura y esperanza nuestra, Dios te salve. A Ti clamamos los desterrados hijos de Eva; a Ti suspiramos, gimiendo y llorando en este valle de lágrimas. Ea, pues, Señora, abogada nuestra, vuelve a nosotros esos tus ojos misericordiosos; y después de este destierro, muéstranos a Jesús, fruto bendito de tu vientre. ¡Oh clemente, oh piadosa, oh dulce Virgen María! Ruega por nosotros, Santa Madre de Dios, para que seamos dignos de alcanzar las promesas de nuestro Señor Jesucristo. Amén.")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14).fill(Color.white.opacity(0.75))
                        )
                }

                Spacer(minLength: 24)
            }
            .padding()
        }
        .background(Color(red: 0.96, green: 0.98, blue: 1.0).ignoresSafeArea())
        .navigationTitle("Virgencita")
        .navigationBarTitleDisplayMode(.inline)
    }
}

fileprivate struct EmbeddedSafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}









#Preview {
    NavigationStack { MenuPrincipalView() }
}
