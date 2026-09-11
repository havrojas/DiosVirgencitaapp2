//dios
//  ContentView.swift
//  diosvirgencita
//virgencita y san jose
//santos de dios
//✝️en nombre de dios✝️
//  Created by Havit on 03/07/26.
//

import SwiftUI
import SafariServices
import MusicKit

struct SacredContentView: View {
    @State private var showMusicPermissionAlert = false
    @State private var playbackMessage: String = ""

    var body: some View {
        SacredInicioView()
    }
}

struct SacredHomeButtonLabel: View {
    let title: String
    let color: Color

    var body: some View {
        Text(title)
            .font(.title2).bold()
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(color.gradient)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.black.opacity(0.05), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

struct SacredLabelIcon: View {
    let systemName: String
    var body: some View {
        Image(systemName: systemName)
            .imageScale(.medium)
            .foregroundStyle(.white.opacity(0.9))
            .padding(.leading, 18)
    }
}

// MARK: - Destinations

struct PadreNuestroScreen: View {
    var body: some View {
        ZStack {
            // Soft gradient background
            LinearGradient(colors: [Color(.systemGroupedBackground), Color(.secondarySystemBackground)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // Header image (uses asset named "virgen" if available)
                    HeaderImage()

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Padre Nuestro")
                            .font(.system(size: 38, weight: .bold, design: .serif))
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Divider().opacity(0.2)

                        Text(
"Padre nuestro, que estás en el cielo,\nsantificado sea tu Nombre;\nvenga a nosotros tu reino;\nhágase tu voluntad en la tierra como en el cielo.\nDanos hoy nuestro pan de cada día;\nperdona nuestras ofensas,\ncomo también nosotros perdonamos a los que nos ofenden;\nno nos dejes caer en la tentación,\ny líbranos del mal. Amén.")
                            .font(.system(size: 22, weight: .regular, design: .serif))
                            .lineSpacing(8)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.primary)
                    }
                    .padding(24)
                    .background(
                        ZStack {
                            // Parchment-like background
                            RoundedRectangle(cornerRadius: 22, style: .continuous)
                                .fill(.ultraThinMaterial)
                            RoundedRectangle(cornerRadius: 22, style: .continuous)
                                .stroke(Color.black.opacity(0.06), lineWidth: 1)
                        }
                    )
                    .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 6)
                    .padding(.horizontal)

                    // Optional devotional footer image
                    FooterDecoration()
                }
                .padding(.vertical, 20)
            }
        }
        .navigationTitle("Padre Nuestro")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct HeaderImage: View {
    var body: some View {
        if let uiImage = UIImage(named: "virgen") {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(22)
                .overlay(
                    LinearGradient(colors: [Color.black.opacity(0.15), Color.clear], startPoint: .top, endPoint: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                )
                .shadow(color: .black.opacity(0.12), radius: 12, x: 0, y: 8)
                .padding(.horizontal)
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(Color.accentColor.opacity(0.12))
                Image(systemName: "cross.fill")
                    .font(.system(size: 56, weight: .regular))
                    .foregroundStyle(Color.accentColor)
            }
            .frame(height: 160)
            .padding(.horizontal)
        }
    }
}

private struct FooterDecoration: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "leaf.fill").foregroundStyle(.green)
            Rectangle().frame(height: 1).foregroundStyle(.secondary).opacity(0.2)
            Image(systemName: "sun.max.fill").foregroundStyle(.yellow)
            Rectangle().frame(height: 1).foregroundStyle(.secondary).opacity(0.2)
            Image(systemName: "heart.fill").foregroundStyle(.pink)
        }
        .padding(.horizontal)
        .padding(.top, 4)
        .opacity(0.8)
    }
}

struct SalmosMenuView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                SalmoButton(title: "Salmo 1", color: .red, destination: SalmoDetailView(title: "Salmo 1", content: sampleSalmo1))
                SalmoButton(title: "Salmo 2", color: .orange, destination: SalmoDetailView(title: "Salmo 2", content: "Contenido del Salmo 2 próximamente"))
                SalmoButton(title: "Salmo 3", color: .yellow, destination: SalmoDetailView(title: "Salmo 3", content: "Contenido del Salmo 3 próximamente"))
                SalmoButton(title: "Salmo 4", color: .green, destination: SalmoDetailView(title: "Salmo 4", content: "Contenido del Salmo 4 próximamente"))
                SalmoButton(title: "Salmo 5", color: .blue, destination: SalmoDetailView(title: "Salmo 5", content: "Contenido del Salmo 5 próximamente"))
                if let url = URL(string: "https://sendero-fe-guia.base44.app/salmos") {
                    Link(destination: url) {
                        Label("Ver salmos en la web", systemImage: "safari")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(RoundedRectangle(cornerRadius: 14).fill(Color.accentColor.opacity(0.15)))
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle("Salmos")
    }
}

struct SalmoButton<Destination: View>: View {
    let title: String
    let color: Color
    let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            Text(title)
                .font(.title2).bold()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(color.gradient)
                )
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
        }
    }
}

struct SalmoDetailView: View {
    let title: String
    let content: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .font(.largeTitle).bold()
                Text(content)
                    .font(.system(size: 20, weight: .regular, design: .serif))
                    .lineSpacing(6)
                    .multilineTextAlignment(.leading)
            }
            .padding()
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private let sampleSalmo1 = """
LIBRO I\nEl justo y los pecadores\n\n1 Bienaventurado el varón que no anduvo en consejo de malos,\nni estuvo en camino de pecadores,\nni en silla de escarnecedores se ha sentado;\n2 sino que en la ley de Jehová está su delicia,\ny en su ley medita de día y de noche.\n3 Será como árbol plantado junto a corrientes de aguas,\nque da su fruto en su tiempo,\ny su hoja no cae;\ny todo lo que hace, prosperará.\n4 No así los malos,\nque son como el tamo que arrebata el viento.\n5 Por tanto, no se levantarán los malos en el juicio,\nni los pecadores en la congregación de los justos.\n6 Porque Jehová conoce el camino de los justos;\nmas la senda de los malos perecerá.
"""

struct VirgencitaOracionesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                OracionCard(title: "La Salve", subtitle: "Virgen María", destination: AnyView(LaSalveView()))
                OracionCard(title: "Bajo tu amparo", subtitle: "Oración antigua", destination: AnyView(BajoTuAmparoView()))
                OracionCard(title: "Préstame, Madre…", subtitle: "Devoción popular", destination: AnyView(PrestameMadreView()))

                // Enlace externo (pendiente de link real)
                if let url = URL(string: "https://tu-enlace-oraciones.com") {
                    Link(destination: url) {
                        Label("Ver oraciones en la web", systemImage: "safari")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(RoundedRectangle(cornerRadius: 14).fill(Color.accentColor.opacity(0.15)))
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle("Virgencita")
    }
}

struct OracionCard: View {
    let title: String
    let subtitle: String
    let destination: AnyView

    var body: some View {
        NavigationLink(destination: destination) {
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: "heart.fill")
                    .foregroundStyle(.pink)
                    .imageScale(.large)
                VStack(alignment: .leading, spacing: 4) {
                    Text(title).font(.headline)
                    Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right").foregroundStyle(.secondary)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
            )
        }
    }
}

struct LaSalveView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("La Salve")
                    .font(.system(size: 34, weight: .bold, design: .serif))
                Text("Dios te salve, Reina y Madre de misericordia;\nvida, dulzura y esperanza nuestra;\nDios te salve. A ti clamamos los desterrados hijos de Eva;\nsuspirando y gimiendo y llorando en este valle de lágrimas.\nEa, pues, Señora, abogada nuestra,\nvuelve a nosotros esos tus ojos misericordiosos;\ny después de este destierro, muéstranos a Jesús,\nfruto bendito de tu vientre.\nOh clemente, oh piadosa,\noh dulce Virgen María.\nRuega por nosotros Santa Madre de Dios,\npara que seamos dignos de alcanzar las promesas de nuestro Señor Jesucristo. Amén.")
                    .font(.system(size: 20, weight: .regular, design: .serif))
                    .lineSpacing(6)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 6)
            )
            .padding()
        }
        .navigationTitle("La Salve")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BajoTuAmparoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Bajo tu amparo")
                    .font(.system(size: 34, weight: .bold, design: .serif))
                Text("Bajo tu amparo nos acogemos, Santa Madre de Dios.\nNo desoigas nuestras súplicas que te dirigimos en nuestras necesidades;\nante bien, líbranos de todos los peligros, Virgen gloriosa y bendita. Amén.")
                    .font(.system(size: 20, weight: .regular, design: .serif))
                    .lineSpacing(6)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 6)
            )
            .padding()
        }
        .navigationTitle("Bajo tu amparo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PrestameMadreView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Préstame, Madre…")
                    .font(.system(size: 34, weight: .bold, design: .serif))
                Text("Préstame, Madre, tus ojos, para con ellos mirar,\nporque si con ellos miro, nunca volveré a pecar.\nPréstame, Madre, tus labios, para con ellos rezar,\nporque si con ellos rezo, Jesús me podrá escuchar.\nPréstame, Madre, tu lengua, para poder comulgar,\npues es tu lengua materna de amor y de santidad.\nPréstame, Madre, tus brazos, para poder trabajar,\nque así rendiré el trabajo, y rendiré a mi Señor más.\nPréstame, Madre, tu manto, para cubrir mi maldad,\npues cubierto con tu manto al Cielo he de llegar.\nPréstame, Madre, a tu Hijo, para poderlo yo amar,\nsi me das a Jesús, ¿qué más puedo yo desear?\nY esa será mi dicha por toda la eternidad. Amén.")
                    .font(.system(size: 20, weight: .regular, design: .serif))
                    .lineSpacing(6)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 6)
            )
            .padding()
        }
        .navigationTitle("Préstame, Madre…")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RosarioView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Rosario")
                .font(.largeTitle).bold()
            Text("Próximamente: enlaces a audios y misterios.")
                .foregroundStyle(.secondary)
            if let url = URL(string: "https://opusdei.org/es-mx/article/santo-rosario-audio/") {
                Link(destination: url) {
                    Label("Abrir lista de audios", systemImage: "play.circle.fill")
                        .font(.headline)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color.accentColor.opacity(0.15)))
                }
            }
        }
        .padding()
        .navigationTitle("Rosario")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WebBrowserView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

struct NowPlayingBar: View {
    @State private var isPlaying: Bool = false
    @State private var currentTitle: String = ""

    private var player: ApplicationMusicPlayer { ApplicationMusicPlayer.shared }

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "music.note")
                .imageScale(.large)
                .foregroundStyle(.primary)

            VStack(alignment: .leading, spacing: 2) {
                Text(currentTitle.isEmpty ? "Reproductor" : currentTitle)
                    .font(.subheadline).fontWeight(.semibold)
                    .lineLimit(1)
                Text(isPlaying ? "Reproduciendo" : "Pausado")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button {
                Task { await togglePlayPause() }
            } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.title3)
                    .padding(8)
            }
            Button {
                Task { await skipToNext() }
            } label: {
                Image(systemName: "forward.fill")
                    .font(.title3)
                    .padding(8)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.black.opacity(0.05), lineWidth: 1)
        )
        .onAppear { Task { await refreshState() } }
    }

    @MainActor
    private func refreshState() async {
        do {
            let state = try await player.state
            self.isPlaying = state.playbackStatus == .playing

            // Derive the current item's title using supported APIs
            if let entryTitle = player.queue.currentEntry?.title {
                self.currentTitle = entryTitle
            } else if let firstTitle = player.queue.entries.first?.title {
                // Fallback: use the first entry title if available
                self.currentTitle = firstTitle
            } else {
                self.currentTitle = ""
            }
        } catch {
            // Silently ignore for now
        }
    }

    @MainActor
    private func togglePlayPause() async {
        do {
            if isPlaying {
                try await player.pause()
                isPlaying = false
            } else {
                try await player.play()
                isPlaying = true
            }
            await refreshState()
        } catch {
            // Silently ignore
        }
    }

    @MainActor
    private func skipToNext() async {
        do {
            try await player.skipToNextEntry()
            await refreshState()
        } catch {
            // Silently ignore
        }
    }
}

struct SacredInicioView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    NavigationLink {
                        PadreNuestroScreen()
                    } label: {
                        HStack(spacing: 0) {
                            SacredLabelIcon(systemName: "hands.sparkles.fill")
                            SacredHomeButtonLabel(title: "Padre Nuestro", color: .indigo)
                        }
                    }

                    NavigationLink {
                        SalmosMenuView()
                    } label: {
                        HStack(spacing: 0) {
                            SacredLabelIcon(systemName: "book.fill")
                            SacredHomeButtonLabel(title: "Salmos", color: .teal)
                        }
                    }

                    NavigationLink {
                        VirgencitaOracionesView()
                    } label: {
                        HStack(spacing: 0) {
                            SacredLabelIcon(systemName: "heart.circle.fill")
                            SacredHomeButtonLabel(title: "Virgencita", color: .pink)
                        }
                    }

                    NavigationLink {
                        RosarioView()
                    } label: {
                        HStack(spacing: 0) {
                            SacredLabelIcon(systemName: "rosary")
                            SacredHomeButtonLabel(title: "Rosario", color: .purple)
                        }
                    }

                    // Optional: show the now playing bar if you want quick access to playback controls
                    NowPlayingBar()
                        .padding(.top, 8)
                }
                .padding(20)
            }
            .navigationTitle("Inicio Sagrado")
        }
    }
}

#Preview {
    SacredContentView()
}

