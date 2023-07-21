//
//  ExploreGrid.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 20/07/2023.
//

import SwiftUI

struct GalleryView: View {
 
    // Definir alturas predefinidas
    let predefinedHeights: [CGFloat] = [150, 200, 250, 300, 350]
    
    // Función para obtener una altura aleatoria de las alturas predefinidas
    func getRandomHeight() -> CGFloat {
        return predefinedHeights.randomElement() ?? 250 // Valor por defecto de 250 si no se puede obtener un valor aleatorio
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                HStack(alignment: .top, spacing: 5) {
                    LazyVStack { 
                        ForEach(Gallery.sampleData.prefix(Gallery.sampleData.count / 2), id: \.id) { item in
                            Image(item.image)
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: getRandomHeight())
                                .clipped()
                                .cornerRadius(10)
                        }
                    }
                    LazyVStack { // Cambio a LazyVStack
                        ForEach(Gallery.sampleData.suffix(Gallery.sampleData.count / 2), id: \.id) { item in
                            Image(item.image)
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: getRandomHeight())
                                .clipped()
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(5)
                .navigationTitle("Galeria")
            }
        }
    }
}




struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
