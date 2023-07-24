//
//  HomeView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 23/05/2023.
//

import SwiftUI

struct HomeView: View {
    let items: [Items]
    let colums = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    let background = Color("Background")
    let spacing: CGFloat = 10
    
    func getViewForItem(_ item: Items) -> some View {
        switch item.title {
        case "Reservar":
            return AnyView(BarberListView(barbers: Barber.sampleData))
        case "Ubicación":
            return AnyView(Location())
        case "Galeria":
            return AnyView(GalleryView())
        default:
            return AnyView(Text("Vista no implementada"))
        }
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                HeaderView()
                    
                LazyVGrid(columns: colums, spacing: spacing ) {
                    ForEach(items) { item in
                        NavigationLink(destination: getViewForItem(item)) {
                            ItemView(items: item)
                        }
                        .buttonStyle(ItemButtonStyle(cornerRadius: 10))
                    }
                }
                .padding(.horizontal)
                .offset(y: -50)
            }
            //.navigationBarTitle("Jacquet’s")
            .background(Color.white)
            .ignoresSafeArea()
            
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(items: Items.sampleData)
    }
}


struct Navbar: View {
    var body: some View {
        VStack(spacing: 0) {
            
            
            Spacer()
            
            Divider()
                .overlay(Color("Decoracion"))
                .frame(height: 1)
                .opacity(0.4)
                .padding(.horizontal, 20)
            
            Spacer()
            
        }
    }
}


struct ItemView: View {
    let items: Items
    var body: some View {
        GeometryReader { reader in
            
            // let fontSize = min(reader.size.width * 0.2,28)
            let imageWidth: CGFloat = min(50, reader.size.width * 0.6)
            
            VStack {
                Image(items.image)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(items.imgColor)
                    .frame(width: imageWidth)
                
                Text(items.title)
                    .font(.system(size: 20, weight: .bold,design: .rounded))
                    .foregroundColor(Color.black.opacity(0.9))
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .background(Color.white)
            
        }
        .frame(height: 150)
        //        .clipShape(RoundedRectangle(cornerRadius: 20))
        //        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
}

struct HeaderView: View {
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                
                Text("Jacquet’s")
                    .font(.system(size: 33, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Divider()
                    .overlay(Color("Decoracion"))
                    .frame(height: 1)
                    .opacity(0.4)
                    .padding(.horizontal, 20)
                
                
            }
            .padding(.top, 40)
            
            Text("Servicios")
                .font(.title)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            
        }
        .frame(height: 250)
        .frame(maxWidth: .infinity)
        .background(Color("Background"))
        .clipShape(CustomShape(corner: [.bottomLeft,.bottomRight], radii: 10))
    }
}

struct ItemButtonStyle: ButtonStyle {
    let cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
            if configuration.isPressed {
                Color.black.opacity(0.2)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
}


struct CustomShape: Shape {
    var corner : UIRectCorner
    var radii : CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radii, height: radii))
        
        return Path(path.cgPath)
    }
}

