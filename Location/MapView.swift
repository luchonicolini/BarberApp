//
//  MapView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 19/07/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var region = MKCoordinateRegion(center: BarberLocation.example.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [BarberLocation.example]) { location in
            MapMarker(coordinate: location.coordinate, tint: .red)
            
        }
        .onTapGesture {
            let destination = MKMapItem(placemark: MKPlacemark(coordinate: BarberLocation.example.coordinate))
            destination.name = BarberLocation.example.name
            MKMapItem.openMaps(with: [destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }
        .cornerRadius(10)
//        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 0.5))
//        .frame(height: 350) // Puedes ajustar la altura según lo desees
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
