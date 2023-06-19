//
//  BarberListView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 29/05/2023.
//

import SwiftUI

struct BarberListView: View {
    @StateObject var viewModel = ReservationViewModel()
    @State private var showSuccessMessage = false
   
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Barbero")) {
                    Picker(selection: $viewModel.seleccionbarber, label: Text("Seleccione un profesional")) {
                        Text("Luciano").tag("Luciano")
                        Text("Juan").tag("Juan")
                        Text("Pedro").tag("Pedro")
                    }
                }
                
                Section(header: Text("Servicio")) {
                    Picker(selection: $viewModel.seleccionCorte, label: Text("Seleccione un servicio")) {
                        Text("Corte").tag("Corte")
                        Text("Barba").tag("Barba")
                        Text("Combo").tag("Combo")
                    }
                }
                
                Section(header: Text("Fecha y horario")) {
                    DatePicker("Fecha", selection: $viewModel.fecha, displayedComponents: .date)
                    DatePicker("Horario", selection: $viewModel.horario, displayedComponents: .hourAndMinute)
                }
                
                Section {
                    Button(action: {
                        viewModel.saveReservation()
                        showSuccessMessage = true
                    }) {
                        Text("Siguiente")
                    }
                }
            }
        }
        .alert(isPresented: $showSuccessMessage) {
            Alert(
                title: Text("Reserva Exitosa"),
                message: Text("Su reserva ha sido guardada exitosamente."),
                dismissButton: .default(Text("Aceptar"))
            )
        }
    }
}



struct BarberListView_Previews: PreviewProvider {
    static var previews: some View {
        BarberListView()
    }
}





