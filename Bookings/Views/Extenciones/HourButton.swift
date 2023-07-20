//
//  HourButton.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 13/07/2023.
//

import Foundation
import SwiftUI

struct HourButton: View {
    var hour: Int
    var isSelected: Bool
    
    var body: some View {
        VStack {
            Text("\(hour):00")
                .foregroundColor(.black)
                .padding(10)
                .background(isSelected ? Color.yellow : Color.gray)
                .cornerRadius(5)
                .scaleEffect(isSelected ? 1.1 : 1.0)
        }
    }
}

struct HourButton_Previews: PreviewProvider {
    static var previews: some View {
        HourButton(hour: 12, isSelected: false)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
