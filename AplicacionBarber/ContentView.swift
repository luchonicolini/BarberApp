//
//  ContentView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 22/05/2023.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color("TabBarColor"))
    }
    
    var body: some View {
        TabView {
            HomeView(items: Items.sampleData)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Inicio")
                }
            
            Text("Segunda vista")
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Notificaciones")
                }
            
            Text("Tercera vista")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Perfil")
                }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
