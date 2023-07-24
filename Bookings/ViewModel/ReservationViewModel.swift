//
//  FirestoreViewModel.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 30/05/2023.
//

import SwiftUI
import Firebase
import FirebaseDatabase

class ReservationViewModel: ObservableObject {
    
    @Published var barbers: [Barber] = []
    private var dbRef: DatabaseReference = Database.database().reference().child("barbers")
    
    init() {
        fetchBarbers()
    }
    
    // Función para añadir un Barbero
    func addBarber(barber: Barber) {
        let barberRef = dbRef.child(barber.id.uuidString)
        barberRef.setValue([
            "imageName": barber.imageName,
            "name": barber.name,
            "description": barber.description
        ])
    }
    
    // Función para obtener los Barberos
    func fetchBarbers() {
        dbRef.observe(.value, with: { [weak self] (snapshot) in
            // Línea de depuración para imprimir los datos recuperados
            print(snapshot.value as Any)
            
            var newBarbers: [Barber] = []
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let barber = Barber(snapshot: childSnapshot) {
                    newBarbers.append(barber)
                }
            }
            
            DispatchQueue.main.async {
                self?.barbers = newBarbers
            }
            
        }, withCancel: { (error) in
            print("Failed to fetch barbers: \(error.localizedDescription)")
            // Aquí puedes manejar el error como prefieras
        })
    }
    
    deinit {
        dbRef.removeAllObservers()
    }
}

extension Barber {
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: AnyObject],
              let imageName = value["imageName"] as? String,
              let name = value["name"] as? String,
              let description = value["description"] as? String else {
            return nil
        }
        
        self.id = UUID(uuidString: snapshot.key) ?? UUID()
        self.imageName = imageName
        self.name = name
        self.description = description
    }
}











