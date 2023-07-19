//
//  FirestoreViewModel.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 30/05/2023.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore


class ReservationViewModel: ObservableObject {
    let db = Firestore.firestore()
    let reservasCollection = "Reservas"
    let barberosCollection = "Barberos"

    
    @Published var favoriteBarbers: [UUID: Bool] = [:]
    
    

    // Función para obtener los barberos disponibles
    func toggleFavorite(barber: Barber) {
        favoriteBarbers[barber.id] = !(favoriteBarbers[barber.id] ?? false)
    }

}










