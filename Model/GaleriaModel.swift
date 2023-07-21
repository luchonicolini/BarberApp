//
//  GaleriaModel.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 20/07/2023.
//

import Foundation

struct Gallery: Identifiable {
    var id: UUID
    var image: String


    init(id: UUID = UUID(), image: String) {
        self.id = id
        self.image = image

    }
}

extension Gallery {
    static let sampleData: [Gallery] =
    [
        Gallery(image: "uno"),
        Gallery(image: "dos"),
        Gallery(image: "tres"),
        Gallery(image: "uno"),
        Gallery(image: "dos"),
        Gallery(image: "tres"),
        Gallery(image: "uno"),
        Gallery(image: "dos"),
        Gallery(image: "tres"),
        Gallery(image: "uno"),
        Gallery(image: "dos"),
        Gallery(image: "tres"),
     

    ]
}
