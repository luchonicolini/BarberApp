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
    var workingDays: [Int]  
    
    init(id: UUID = UUID(), imageName: String, name: String, description: String, workingDays: [Int] = []) {
        self.id = id
        self.imageName = imageName
        self.name = name
        self.description = description
        self.workingDays = workingDays
    }
}

extension Barber {
    static let sampleData: [Barber] =
    [
        Barber(imageName: "peluquero1", name: "Luciano Nicolini", description: "reserva3reserva3", workingDays: [2, 3, 4, 5, 6, 7]),
        Barber(imageName: "peluquero2", name: "Raul Gonzales", description: "reserva3reserva3", workingDays: [2, 3, 4, 5, 6, 7]),

    ]
}




