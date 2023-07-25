//
//  BarberCell.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 13/07/2023.
//

import SwiftUI

struct BarberCell: View {
    @ObservedObject var viewModel: ReservationViewModel
    let barber: Barber
    var selectedDate: Date

    var body: some View {
        HStack {
            Image(barber.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.gray, lineWidth: 0.5)
                }
            
            VStack(alignment: .leading) {
                Text(barber.name)
                    .font(.headline)
                Text(isBarberAvailable(on: selectedDate) ? "Disponible" : "No Disponible")
                    .font(.caption)
                    .foregroundColor(isBarberAvailable(on: selectedDate) ? .green : .red)
            }
            
            Spacer()
        }
        .padding()
    }
    
    func isBarberAvailable(on date: Date) -> Bool {
        let calendar = Calendar.current
    
        guard let weekday = calendar.dateComponents([.weekday], from: date).weekday else {
            return false
        }
        
        return barber.workingDays.contains(weekday)
    }

}



struct BarberCell_Previews: PreviewProvider {
    static var barber = Barber.sampleData[0]
    static var barbeer = Barber.sampleData[1]
    static var viewModel = ReservationViewModel()

    static var previews: some View {
        Group {
            BarberCell(viewModel: viewModel, barber: barber, selectedDate: Date())
            BarberCell(viewModel: viewModel, barber: barbeer, selectedDate: Date())
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}



