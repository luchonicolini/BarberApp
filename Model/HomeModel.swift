//
//  HomeModel.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 14/07/2023.
//

import Foundation
import SwiftUI

struct Items: Identifiable {
    var id: UUID
    var image: String
    var title: String
    var imgColor: Color
 
    
    init(id: UUID = UUID(), image: String, title: String, imgColor: Color) {
        self.id = id
        self.image = image
        self.title = title
        self.imgColor = imgColor
    }
}

extension Items {
    static let sampleData: [Items] =
    [
        Items(image: "img", title: "Reservar", imgColor: .blue),
        Items(image: "img3", title: "Galeria", imgColor: .yellow),
        Items(image: "img2", title: "asdasd", imgColor: .red),
        Items(image: "img5", title: "Ubicación", imgColor: .green),
        
       
    ]
}
