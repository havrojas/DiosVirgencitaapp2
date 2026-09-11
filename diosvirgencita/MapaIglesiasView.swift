//dios
//virgencita y san jose
//arcangeles y santos de dios
//  MapaIglesiasView.swift
//  diosvirgencita
//
//  Created by Havit on 28/07/26.
//

import SwiftUI
import MapKit
import CoreLocation
internal import Combine
// MARK: - Gestor de Ubicación Real
class RadarLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @State private var favoritas: Set<String> = []

    @Published var userLocation: CLLocationCoordinate2D?
    @Published var isAuthorized = false

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.userLocation = location.coordinate
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            self.isAuthorized = true
            manager.startUpdatingLocation()
        }
    }
}

// MARK: - Modelo para el Radar
struct IglesiaItem: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    let distanceInKm: Double
    
    static func == (lhs: IglesiaItem, rhs: IglesiaItem) -> Bool {
        lhs.name == rhs.name && lhs.coordinate.latitude ==  rhs.coordinate.latitude
    
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Vista Principal Radar de Iglesias
struct RadarIglesiasView: View {
    @StateObject private var locationManager = RadarLocationManager()
    @State private var iglesias: [IglesiaItem] = []
    @State private var isLoading = true
    @State private var selectedIglesia: IglesiaItem?
    @State private var favoritas: Set<String> = []

    // Animación de pulso para el radar
    @State private var isAnimatingRadar = false

    var body: some View {
        VStack(spacing: 0) {
            
            // 📍 Encabezado
            HStack {
                Text("Iglesias más cercanas ✝️")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)

            // 📡 Radar Central Animado
            ZStack {
                // Círculos concéntricos del Radar
                Circle()
                    .stroke(Color.purple.opacity(0.15), lineWidth: 2)
                    .frame(width: 260, height: 260)
                
                Circle()
                    .stroke(Color.purple.opacity(0.25), lineWidth: 2)
                    .frame(width: 180, height: 180)

                Circle()
                    .stroke(Color.purple.opacity(0.35), lineWidth: 2)
                    .frame(width: 100, height: 100)

                // Onda expansiva animada
                Circle()
                    .stroke(Color.purple.opacity(0.4), lineWidth: 1.5)
                    .frame(width: isAnimatingRadar ? 260 : 20, height: isAnimatingRadar ? 260 : 20)
                    .opacity(isAnimatingRadar ? 0 : 1)
                    .animation(.easeOut(duration: 2.5).repeatForever(autoreverses: false), value: isAnimatingRadar)

                // Punto central (Ubicación del usuario)
                ZStack {
                    Circle()
                        .fill(Color.purple.opacity(0.2))
                        .frame(width: 44, height: 44)
                    Circle()
                        .fill(Color.purple)
                        .frame(width: 18, height: 18)
                    Image(systemName: "cross.fill")
                        .font(.system(size: 9))
                        .foregroundColor(.white)
                }

                // Puntos de las iglesias encontradas en el radar
                if !isLoading {
                    ForEach(Array(iglesias.prefix(6)), id: \.id) { iglesia in
                        let offset = calcularOffsetParaRadar(iglesia: iglesia)
                        
                        Button(action: {
                            withAnimation {
                                selectedIglesia = iglesia
                            }
                        }) {
                            VStack(spacing: 2) {
                                ZStack {
                                    Circle()
                                        .fill(selectedIglesia?.id == iglesia.id ? Color.yellow : Color.purple)
                                        .frame(width: 32, height: 32)
                                        .shadow(radius: 3)
                                    Image(systemName: "church.fill")
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .offset(x: offset.width, y: offset.height)
                    }
                }
            }
            .frame(height: 300)
            .onAppear {
                isAnimatingRadar = true
                //busqueda inmediata con ubicacion del gps o de resplado
                let coordActual = locationManager.userLocation ?? CLLocationCoordinate2D(latitude: 19.6823, longitude: -99.1622)
                buscarIglesiasLocales(en: coordActual)
            }

            Spacer()

            // 🃏 Lista de Tarjetas Estilo "Gimnasios" (Swipe horizontal)
            if isLoading {
                VStack(spacing: 10) {
                    ProgressView()
                    Text("Escaneando iglesias locales...")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 40)
            } else if iglesias.isEmpty {
                Text("No se encontraron iglesias cercanas en esta área.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 40)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(iglesias) { iglesia in
                            
                            // 🛑 AQUÍ REEMPLAZAS LO QUE TIENES EN LAS LÍNEAS 173 A 179 POR ESTO:
                            
                            IglesiaCardView(
                                iglesia: iglesia,
                                isSelected: selectedIglesia?.id == iglesia.id,
                                isFavorite: favoritas.contains(iglesia.name),
                                onFavoriteToggle: {
                                    if favoritas.contains(iglesia.name) {
                                        favoritas.remove(iglesia.name)
                                    } else {
                                        favoritas.insert(iglesia.name)
                                    }
                                },
                                onNavigate: {
                                    abrirEnAppleMaps(iglesia: iglesia)
                                }
                            )
                            .onTapGesture {
                                withAnimation {
                                    selectedIglesia = iglesia
                                }
                            }

                        }
                    }
                }

            }
        }
        .onAppear {
            // Si ya hay ubicación la usa; de lo contrario usará la que reciba la actualización de GPS
            if let userCoord = locationManager.userLocation {
                buscarIglesiasLocales(en: userCoord)
            }
        }
        .onChange(of: locationManager.userLocation) { newLocation in
            if let location = newLocation {
                buscarIglesiasLocales(en: location)
            }
        }
    }
//Mark:abiri en apple maps
    private func abrirEnAppleMaps(iglesia: IglesiaItem) {
        let placemark = MKPlacemark(coordinate: iglesia.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = iglesia.name
        
        // Abre Apple Maps con indicaciones de cómo llegar
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }

    // 🔍 Búsqueda en MapKit basada en GPS local (Radio de 4 km)
    private func buscarIglesiasLocales(en userCoord: CLLocationCoordinate2D) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "iglesia"
        
        // Región centrada en las coordenadas recibidas
        request.region = MKCoordinateRegion(
            center: userCoord,
            latitudinalMeters: 5000, // 5 km a la redonda
            longitudinalMeters: 5000
        )

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            // Si hay error o no responde MapKit, no congelamos la pantalla
            guard let response = response, error == nil else {
                print("⚠️ Error en MapKit: \(error?.localizedDescription ?? "Desconocido")")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }

            let userLoc = CLLocation(latitude: userCoord.latitude, longitude: userCoord.longitude)

            let resultados = response.mapItems.map { item -> IglesiaItem in
                let itemLoc = CLLocation(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
                let distEnKm = userLoc.distance(from: itemLoc) / 1000.0
                
                let direccion = [item.placemark.thoroughfare, item.placemark.subLocality]
                    .compactMap { $0 }
                    .joined(separator: ", ")

                return IglesiaItem(
                    name: item.name ?? "Iglesia / Parroquia",
                    address: direccion.isEmpty ? "Localidad cercana" : direccion,
                    coordinate: item.placemark.coordinate,
                    distanceInKm: distEnKm
                )
            }.sorted { $0.distanceInKm < $1.distanceInKm }

            DispatchQueue.main.async {
                self.iglesias = resultados
                self.selectedIglesia = resultados.first
                self.isLoading = false
            }
        }
    }
    




    // 📐 Posiciona los puntos dentro del gráfico del radar según distancia
    private func calcularOffsetParaRadar(iglesia: IglesiaItem) -> CGSize {
        let maxRadius: CGFloat = 100.0
        // Repartimos los puntos usando un radio mínimo para que no se encimen en el centro
        let minRadius: CGFloat = 35.0
        let distFactor = CGFloat(min(iglesia.distanceInKm / 3.0, 1.0))
        let radius = minRadius + (distFactor * (maxRadius - minRadius))
        
        // Ángulos bien distribuidos
        let hashValue = abs(iglesia.name.hashValue)
        let angle = Double(hashValue % 360) * (.pi / 180.0)
        
        let x = cos(angle) * Double(radius)
        let y = sin(angle) * Double(radius)
        
        return CGSize(width: x, height: y)
    }

}

// MARK: - Componente de Tarjeta
/*struct IglesiaCardView: View {
    let iglesia: IglesiaItem
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Fondo con degradado e ícono
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: [Color.purple.opacity(0.7), Color.indigo],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 90)
                
                Image(systemName: "church.fill")
                    .font(.system(size: 36))
                    .foregroundColor(.white)
                    .shadow(radius: 2)
            }

            Text(iglesia.name)
                .font(.headline)
                .lineLimit(1)
                .foregroundColor(.primary)

            Text(iglesia.address)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)

            HStack {
                Image(systemName: "location.fill")
                    .font(.caption2)
                    .foregroundColor(.purple)
                Text(String(format: "%.1f km", iglesia.distanceInKm))
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
            }
        }
        .padding(12)
        .frame(width: 170)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(16)
        .shadow(color: isSelected ? Color.purple.opacity(0.35) : Color.black.opacity(0.08), radius: isSelected ? 8 : 4, x: 0, y: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? Color.purple : Color.clear, lineWidth: 2)
        )
    }
}*/
/*struct IglesiaCardView: View {
    let iglesia: IglesiaItem
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 🗺️ Foto Satelital / Mapa de Apple Maps con un pincito de iglesia encima
            ZStack(alignment: .topTrailing) {
                AppleMapsSnapshotView(coordinate: iglesia.coordinate)
                    .cornerRadius(12)

                // Pin decorativo
                Image(systemName: "church.fill")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.purple)
                    .clipShape(Circle())
                    .padding(6)
            }

            Text(iglesia.name)
                .font(.headline)
                .lineLimit(1)
                .foregroundColor(.primary)

            Text(iglesia.address)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)

            HStack {
                Image(systemName: "location.fill")
                    .font(.caption2)
                    .foregroundColor(.purple)
                Text(String(format: "%.1f km", iglesia.distanceInKm))
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
            }
        }
        .padding(12)
        .frame(width: 170)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(16)
        .shadow(color: isSelected ? Color.purple.opacity(0.35) : Color.black.opacity(0.08), radius: isSelected ? 8 : 4, x: 0, y: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? Color.purple : Color.clear, lineWidth: 2)
        )
    }
}
*/
struct IglesiaCardView: View {
    let iglesia: IglesiaItem
    let isSelected: Bool
    let isFavorite: Bool
    let onFavoriteToggle: () -> Void
    let onNavigate: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 📸 Mapa miniatura con botón de favorito arriba a la derecha
            ZStack(alignment: .topTrailing) {
                AppleMapsSnapshotView(coordinate: iglesia.coordinate)
                    .cornerRadius(12)

                // Botón de Corazón
                Button(action: onFavoriteToggle) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.caption)
                        .foregroundColor(isFavorite ? .red : .white)
                        .padding(6)
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                }
                .padding(6)
            }

            Text(iglesia.name)
                .font(.headline)
                .lineLimit(1)
                .foregroundColor(.primary)

            Text(iglesia.address)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)

            HStack {
                Image(systemName: "location.fill")
                    .font(.caption2)
                    .foregroundColor(.purple)
                Text(String(format: "%.1f km", iglesia.distanceInKm))
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                
                Spacer()
                
                // Botón para abrir ruta en Apple Maps
                Button(action: onNavigate) {
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                        Text("Ir")
                    }
                    .font(.caption2.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
        }
        .padding(12)
        .frame(width: 190)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(16)
        .shadow(color: isSelected ? Color.purple.opacity(0.35) : Color.black.opacity(0.08), radius: isSelected ? 8 : 4, x: 0, y: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? Color.purple : Color.clear, lineWidth: 2)
        )
    }
}



// 🧩 Permite a SwiftUI comparar coordenadas con .onChange
extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}



// 📸 Componente que genera la imagen en miniatura de Apple Maps
struct AppleMapsSnapshotView: View {
    let coordinate: CLLocationCoordinate2D
    @State private var snapshotImage: UIImage? = nil

    var body: some View {
        Group {
            if let image = snapshotImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                // Mientras carga la foto de Apple Maps
                ZStack {
                    Color.purple.opacity(0.15)
                    ProgressView()
                }
            }
        }
        .frame(height: 90)
        .clipped()
        .onAppear {
            generarFotoDeMapa()
        }
    }

    private func generarFotoDeMapa() {
        let options = MKMapSnapshotter.Options()
        options.region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 200, // Zoom cercano a la iglesia
            longitudinalMeters: 200
        )
        options.size = CGSize(width: 170, height: 90)
        options.scale = UIScreen.main.scale
        options.mapType = .standard // O puedes usar .hybridFlyover para vista aérea

        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            if let image = snapshot?.image {
                DispatchQueue.main.async {
                    self.snapshotImage = image
                }
            }
        }
    }
}


#Preview {
    RadarIglesiasView()
}
