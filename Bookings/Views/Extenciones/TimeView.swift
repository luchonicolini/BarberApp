//
//  TimeView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 30/05/2023.
//

import SwiftUI

struct TimeView: View {
    let time: Date

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
               // Text(DateFormatter.timeFormatter.string(from: time))
               //     .font(.headline)
                
            
            }

        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}



//struct TimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeView(time: <#Date#>)
//    }
//}
