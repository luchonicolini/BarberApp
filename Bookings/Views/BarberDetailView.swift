//
//  BarberDetailView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 30/05/2023.
//

import SwiftUI

struct BarberDetailView: View {
    let barber: Barber
    
    var body: some View {
        VStack {
            Image(barber.photo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 140)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Text(barber.name)
                .font(.title2)
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding()
        .navigationTitle(barber.name)
    }
}


struct BarberDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let barber = Barber(name: "John", photo: "peluqueria1", apellido: "Doe", horario: "10:00 AM", tipoCorte: "Corte Clásico")
        return BarberDetailView(barber: barber)
    }
}
