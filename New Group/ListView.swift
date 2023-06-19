//
//  ListView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 23/05/2023.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        HStack(spacing: 16) {
            Image("reserva")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            Rectangle()
                .frame(width: 1, height: 40)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Reserva")
                    .font(.title3)
                    .fontWeight(.medium)
             
            }

        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
