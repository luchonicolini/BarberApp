//
//  ServiceModels.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 23/05/2023.
//

import Foundation
import Combine

struct Barber: Identifiable {
    var id: UUID
    var imageName: String
    var name: String
    var description: String
 
    
    init(id: UUID = UUID(), imageName: String, name: String, description: String) {
        self.id = id
        self.imageName = imageName
        self.name = name
        self.description = description

    }
}

extension Barber {
    static let sampleData: [Barber] =
    [
        Barber(imageName: "peluquero1", name: "Luciano Nicolini", description: "reserva3reserva3"),
        Barber(imageName: "peluquero2", name: "Raul Gonzales", description: "reserva3reserva3"),
        Barber(imageName: "peluquero3", name: "Luciano Nicolini", description: "reserva3reserva3"),
        Barber(imageName: "peluquero2", name: "Raul Gonzales", description: "reserva3reserva3")
        
       
    ]
}



