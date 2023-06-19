//
//  ServiceModels.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 23/05/2023.
//

import Foundation
import Combine

struct Reservation: Identifiable, Codable {
    var id = UUID()
    let barber: Barber
    let service: HaircutService
    let date: Date
    let phoneNumber: String
    
    init(id: UUID = UUID(), barber: Barber, service: HaircutService, date: Date, phoneNumber: String) {
        self.id = id
        self.barber = barber
        self.service = service
        self.date = date
        self.phoneNumber = phoneNumber
    }
}

struct Barber: Identifiable ,Codable, Hashable {
    var id = UUID()
    let name: String
    let photo: String
    let apellido: String
    let horario: String
    let tipoCorte: String
   
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Barber, rhs: Barber) -> Bool {
        return lhs.id == rhs.id
    }
}

struct HaircutService: Codable, Hashable {
    let name: String
    // Puedes agregar más propiedades según tus necesidades, como el precio, duración, etc.
}

var informacion: [Reservation] = [
    Reservation(barber: Barber(name: "Luciano", photo: "peluquero1",apellido: "Doe", horario: "10:00 AM", tipoCorte: "Corte Clásico"), service: HaircutService(name: "Corte Clásico"), date: Date(), phoneNumber: "123456789"),
    Reservation(barber: Barber(name: "Juan", photo: "peluquero2",apellido: "Smith", horario: "11:00 AM", tipoCorte: "Corte Moderno"), service: HaircutService(name: "Corte Moderno"), date: Date(), phoneNumber: "987654321")
]
