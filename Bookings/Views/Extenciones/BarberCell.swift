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
            
                Text(barber.name)
                    .font(.headline)
            
            Spacer()
            if viewModel.favoriteBarbers[barber.id] ?? false {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        viewModel.toggleFavorite(barber: barber)
                    }
            } else {
                Image(systemName: "star")
                    .onTapGesture {
                        viewModel.toggleFavorite(barber: barber)
                    }
            }
        }
        .padding()
    }
}


struct BarberCell_Previews: PreviewProvider {
    static var barber = Barber.sampleData[0]
    static var barbeer = Barber.sampleData[1]
    static var viewModel = ReservationViewModel()

    static var previews: some View {
        Group {
            BarberCell(viewModel: viewModel, barber: barber)
            BarberCell(viewModel: viewModel, barber: barbeer)
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}


