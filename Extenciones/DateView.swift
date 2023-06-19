//
//  DateView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 23/05/2023.
//

import SwiftUI

struct DateView: View {
    var launcher: String
    @State private var date: String = ""
       
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(date.uppercased())
                .font(.footnote)
                .fontWeight(.medium)
                .opacity(0.7)
            
            Text(launcher)
                .font(.largeTitle).bold()
        }
        .onAppear() {
            date =
            Date.now.formatted(.dateTime.weekday().month().day().locale(Locale(identifier: "es-AR")))
           
        }
    }
}

struct SectionHeader: View {
    let text: String
    var body: some View {
        Text(text)
            .padding()
            .frame(width: UIScreen.main.bounds.width, height: 28,alignment: .leading)
            .background(Color.green)
            .foregroundColor(Color.white)
    }
}


struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(launcher: "Novedades")
    }
}
