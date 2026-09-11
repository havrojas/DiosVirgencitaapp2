//dios
//virgencita san jose
//santos y serafines
//Dios
//Virgencita San Jose
//Santos y Serafines
//Dios
//Virgencita San Jose
//Santos y Serafines
import SwiftUI

struct VirgencitaPantallaView: View {
    @State private var selection = 0
    @State private var irAlMenu = false
    @Environment(\.dismiss) private var dismiss

    private let images = ["arca", "escudodavid", "espiritusanto", "jesuquisto", "pescaditohavit", "sagradafamilia"]
    private let autoAdvanceInterval: UInt64 = 2_500_000_000 // 2.5 segundos

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // Enlace invisible directo hacia MenuPrincipalView si dismiss() no tiene a dónde regresar
                NavigationLink(destination: MenuPrincipalView(), isActive: $irAlMenu) {
                    EmptyView()
                }
                .hidden()

                // 1. Carrusel de imágenes directo con protección
                ZStack {
                    if images.indices.contains(selection) {
                        Image(images[selection])
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .ignoresSafeArea()
                            .clipped()
                            .id(selection)
                            .transition(.opacity.combined(with: .scale(scale: 1.02)))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .gesture(
                    DragGesture(minimumDistance: 30, coordinateSpace: .local)
                        .onEnded { value in
                            if value.translation.width < 0 {
                                if selection < images.count - 1 {
                                    withAnimation(.easeInOut(duration: 0.4)) { selection += 1 }
                                } else {
                                    salirAlMenu()
                                }
                            } else if value.translation.width > 0 {
                                if selection > 0 {
                                    withAnimation(.easeInOut(duration: 0.4)) { selection -= 1 }
                                }
                            }
                        }
                )

                // 2. Indicadores y botón de salida
                VStack(spacing: 12) {
                    HStack(spacing: 8) {
                        ForEach(images.indices, id: \.self) { idx in
                            Circle()
                                .fill(idx == selection ? Color.white : Color.white.opacity(0.4))
                                .frame(width: 8, height: 8)
                                .animation(.default, value: selection)
                        }
                    }
                    
                    Button(action: {
                        salirAlMenu()
                    }) {
                        Label("Ir al menú", systemImage: "arrow.right.circle")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(.ultraThinMaterial, in: Capsule())
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 24)
                }
                .padding(.horizontal)
            }
            .navigationBarBackButtonHidden(true)
            .background(Color.black.ignoresSafeArea())
            // 3. Temporizador corregido
            .task {
                selection = 0
                
                for i in 0..<(images.count - 1) {
                    try? await Task.sleep(nanoseconds: autoAdvanceInterval)
                    DispatchQueue.main.async {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            selection = i + 1
                        }
                    }
                }
                
                // Espera final en la última foto y sale
                try? await Task.sleep(nanoseconds: autoAdvanceInterval)
                DispatchQueue.main.async {
                    salirAlMenu()
                }
            }
        }
    }

    // Función híbrida: intenta descartar la pantalla y si no, activa el enlace manual
    private func salirAlMenu() {
        dismiss()
        irAlMenu = true
    }
}

#Preview {
    VirgencitaPantallaView()
}
