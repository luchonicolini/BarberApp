//
//  BarberListView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 29/05/2023.
//

import SwiftUI

struct BarberListView: View {
    @StateObject var viewModel = ReservationViewModel()
    @State private var searchTerm = ""
    let barbers: [Barber]
    
    @State private var showFavoritesOnly = false

    var filteredBarbers: [Barber] {
        barbers.filter { barber in
            searchTerm.isEmpty || barber.name.localizedCaseInsensitiveContains(searchTerm)
        }
    }

    var body: some View {
        NavigationStack {
             List {
                 Section(header: Text("Selecciona un barbero para continuar")) {
                     ForEach(filteredBarbers) { barber in
                         NavigationLink(destination: BarberDetailView()) {
                             BarberCell(viewModel: viewModel, barber: barber)
                         }
                     }
                 }
             }
            .navigationTitle("Barberos")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchTerm, prompt: "Buscar barbero")
        }
    }
}


struct BarberListView_Previews: PreviewProvider {
    static var previews: some View {
        BarberListView(barbers: Barber.sampleData)
    }
}







