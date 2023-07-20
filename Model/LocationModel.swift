//
//  LocationModel.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 18/07/2023.
//


import Foundation
import MapKit

struct BarberLocation: Identifiable {
    var id = UUID()
    var name: String
    var address: String
    var description: String 
    var phoneNumber: String
    var coordinate: CLLocationCoordinate2D
}

// Datos de muestra
extension BarberLocation {
    static let example = BarberLocation(
        name: "Jacquet’s Barbería",
        address: "Av. Corrientes 5868,CABA",
        description: "Ubicada en el corazón de la ciudad, nuestra barbería combina tradición y modernidad para ofrecerte más que un corte una experiencia única. Con barberos expertos y productos de alta calidad, te garantizamos un look impecable y un servicio excepcional. Facil acceso y cerca de puntos clave, te esperamos para que descubras por qué somos la elección de muchos.",
        phoneNumber: "01164825846",
        coordinate: CLLocationCoordinate2D(latitude: -34.59424034251825, longitude: -58.4448196807325)
    )
}

struct BusinessHours {
    var day: String
    var hours: String
}

extension BusinessHours {
    static let weekly: [BusinessHours] = [
        .init(day: "Lunes", hours: "09:00 – 21:00"),
        .init(day: "Martes", hours: "09:00 – 21:00"),
        .init(day: "Miércoles", hours: "09:00 – 21:00"),
        .init(day: "Jueves", hours: "09:00 – 21:00"),
        .init(day: "Viernes", hours: "09:00 – 21:00"),
        .init(day: "Sábado", hours: "09:00 – 21:00"),
        .init(day: "Domingo", hours: "Cerrado")
    ]

    static var formattedHours: String {
        weekly.map { "\($0.day): \($0.hours)" }
            .joined(separator: "\n")
    }
}

