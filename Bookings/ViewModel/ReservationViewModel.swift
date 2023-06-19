//
//  FirestoreViewModel.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 30/05/2023.
//

import SwiftUI
import FirebaseAuth
import Firebase

class ReservationViewModel: ObservableObject {
    // MARK: - Referencias a la base de datos y la colección
    let db = Firestore.firestore()
    let reservasCollection = "Barberia"
    
    // Propiedades del formulario
    @Published var seleccionbarber = ""
    @Published var seleccionCorte = "barba"
    @Published var fecha = Date()
    @Published var horario = Date()
    
    func saveReservation() {
        // Accede a las propiedades del viewModel para obtener los valores seleccionados
        let selectedBarber = seleccionbarber
        let selectedService = seleccionCorte
        let selectedDate = fecha
        let selectedTime = horario
        
        // Aquí puedes realizar las operaciones necesarias para guardar la reserva en la base de datos
        // Por ejemplo, puedes usar la instancia de Firestore y la colección correspondiente
        
        // Ejemplo de guardado en Firestore
        db.collection(reservasCollection).addDocument(data: [
            "barbero": selectedBarber,
            "servicio": selectedService,
            "fecha": selectedDate,
            "horario": selectedTime
        ]) { error in
            if let error = error {
                print("Error al guardar la reserva: \(error)")
            } else {
                print("Reserva guardada exitosamente")
                
                // Aquí puedes realizar alguna acción adicional después de guardar la reserva, como mostrar una alerta o navegar a otra vista
            }
        }
    }
}




