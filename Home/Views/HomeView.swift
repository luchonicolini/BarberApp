//
//  HomeView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 23/05/2023.
//

import SwiftUI

struct HomeView: View {
    let background = Color(.white)
   // @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(background)
                    .edgesIgnoringSafeArea(.all)
                ScrollView(.vertical, showsIndicators: false) {
                 //   Navbar(authViewModel: authViewModel)
                    
                    NavigationLink(
                        destination: BarberListView(),
                        label: {
                            Text("Go to Barber List")
                                .font(.headline)
                        })
                    
                }
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct Navbar: View {
    //@ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            DateView(launcher: "Bienvenido")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            
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



