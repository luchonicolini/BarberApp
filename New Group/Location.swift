//
//  Location.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 17/07/2023.
//

import SwiftUI
import MapKit


struct Location: View {
    // Estado para controlar la región del mapa
    @State private var region = MKCoordinateRegion(center: BarberLocation.example.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    @State private var showHoursAlert = false
    
    var isOpen: Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: Date())
        let day = calendar.component(.weekday, from: Date()) - 1 // El valor 1 corresponde al domingo, por lo que restamos 1 para que coincida con nuestro arreglo
        
        guard day < BusinessHours.weekly.count else { return false }
        
        let todayHours = BusinessHours.weekly[day].hours
        let hoursComponents = todayHours.split(separator: "–").map { $0.trimmingCharacters(in: .whitespaces) }
        
        if hoursComponents.count == 2, let startHour = Int(hoursComponents[0].prefix(2)), let endHour = Int(hoursComponents[1].prefix(2)) {
            return hour >= startHour && hour < endHour
        }
        return false
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Map(coordinateRegion: $region, annotationItems: [BarberLocation.example]) { location in
                        MapMarker(coordinate: location.coordinate, tint: .blue)
                        
                    }
                    .onTapGesture {
                        let destination = MKMapItem(placemark: MKPlacemark(coordinate: BarberLocation.example.coordinate))
                        destination.name = BarberLocation.example.name
                        MKMapItem.openMaps(with: [destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
                    }
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 0.5))
                    .frame(height: 350) // Puedes ajustar la altura según lo desees
                    
                    Text(BarberLocation.example.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Label {
                        Text(BarberLocation.example.address)
                            .font(.subheadline)
                            .opacity(0.7)
                    } icon: {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.gray)
                    }
                  
                    Label {
                        Text("Horarios")
                            .font(.subheadline)
                            .opacity(0.7)
                    } icon: {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        showHoursAlert = true
                    }
                    
                    Label {
                        Text(BarberLocation.example.phoneNumber)
                            .font(.subheadline)
                            .opacity(0.7)
                            .onTapGesture {
                                if let url = URL(string: "tel://\(BarberLocation.example.phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }
                            }
                    } icon: {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.gray)
                    }


                    
                    Label {
                        if isOpen {
                            Text("Abierto ahora")
                        } else {
                            Text("Cerrado - revisa los horarios")
                        }
                    } icon: {
                        Image(systemName: isOpen ? "checkmark.seal.fill" : "xmark.seal.fill")
                            .foregroundColor(isOpen ? .green : .red)
                    }
                    .alert(isPresented: $showHoursAlert) {
                        Alert(title: Text("Horarios de Atención"), message: Text(BusinessHours.formattedHours), dismissButton: .default(Text("Entendido")))
                    }
                    
                }
                .padding()
            }
            .navigationBarTitle("Ubicación", displayMode: .large)
        }
    }
}



struct Location_Previews: PreviewProvider {
    static var previews: some View {
        Location()
    }
}

