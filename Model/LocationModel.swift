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
    var phoneNumber: String
    var coordinate: CLLocationCoordinate2D
}

// Datos de muestra
extension BarberLocation {
    static let example = BarberLocation(name: "Jacquet’s Barbería", address: "Av. Corrientes 5868,CABA", phoneNumber: "01164825846", coordinate: CLLocationCoordinate2D(latitude: -34.59424034251825, longitude: -58.4448196807325))
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
