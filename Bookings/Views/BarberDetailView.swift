//
//  BarberDetailView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 04/07/2023.
//

import SwiftUI

struct BarberDetailView: View {
    @State private var selectedDate = Date()
    @EnvironmentObject var reservationViewModel: ReservationViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 60))
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView {
                    DatePicker("Fecha", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .padding()
                        //.accentColor(.blue)
                    Divider().background(Color.gray)
                       // .frame(height: 2)
                       
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
        BarberDetailView()
    }
}














