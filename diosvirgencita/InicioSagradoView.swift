import SwiftUI

struct ImageGridView: View {
    // The six image asset names
    private let imageNames = [
        "arcad",
        "jesuquistod",
        "sagradafamiliad",
        "pescaditohavit",
        "escudodavidd",
        "espiritusantod"
    ]
    
    // Optional loading state
    @State private var isLoading = true
    
    var body: some View {
        NavigationView {
            ZStack {
                // Serene pastel background
                LinearGradient(
                    gradient: Gradient(colors: [Color("PastelBlue"), Color("PastelLavender")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                if isLoading {
                    VStack(spacing: 20) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.white.opacity(0.8)))
                            .scaleEffect(1.5)
                        Text("Loading...")
                            .font(.headline)
                            .foregroundColor(Color.white.opacity(0.8))
                    }
                    .transition(.opacity)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(imageNames, id: \.self) { name in
                                NavigationLink(destination: MenuPrincipalView()) {
                                    Image(name)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 140)
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                        .cornerRadius(15)
                                        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                        )
                                }
                            }
                        }
                        .padding(20)
                    }
                    .transition(.opacity)
                }
            }
            .navigationTitle("Image Gallery")
        }
        .onAppear {
            // Simulate brief loading
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                withAnimation {
                    isLoading = false
                }
            }
        }
    }
}

// Simple placeholder destination view
struct PlaceholderDetailView: View {
    let title: String
    
    var body: some View {
        ZStack {
            Color("PastelBlue")
                .ignoresSafeArea()
            Text("Destination for \(title)")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color.white.opacity(0.85))
                .padding()
                .background(Color.white.opacity(0.25))
                .cornerRadius(12)
                .shadow(radius: 8)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView()
            .preferredColorScheme(.light)
            // Sample pastel colors in assets or define here for preview
            .environment(\.colorScheme, .light)
    }
}
