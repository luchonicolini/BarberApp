//
//  BarberDetailView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 04/07/2023.
//

import SwiftUI

struct BarberDetailView: View {
    var barber: Barber
    @State private var selectedDate = Date()
    @State private var showError = false

    @EnvironmentObject var reservationViewModel: ReservationViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 60))
    ]

    func isWorkingDay(date: Date) -> Bool {
        let calendar = Calendar.current
        if let weekday = calendar.dateComponents([.weekday], from: date).weekday {
            return barber.workingDays.contains(weekday)
        }
        return false
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView {
                    DatePicker("Fecha", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .padding()
                        .onChange(of: selectedDate) { newDate in
                            if !isWorkingDay(date: newDate) {
                                showError = true
                            } else {
                                showError = false
                            }
                        }
                    if showError {
                        Text("El barbero no está disponible en la fecha seleccionada.")
                            .foregroundColor(.red)
                            .padding()
                    }
                    Divider().background(Color.gray)
                    //
                    
                    
                
                }
                .padding()
            }
            .navigationBarTitle(Text("Calendario"))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}



struct BarberDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BarberDetailView(barber: Barber.sampleData[0])
            .environmentObject(ReservationViewModel())
    }
}















