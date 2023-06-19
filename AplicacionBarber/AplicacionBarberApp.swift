//
//  AplicacionBarberApp.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 22/05/2023.
//

import SwiftUI
import FirebaseCore

@main
struct AplicacionBarber: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  
  @StateObject private var authenticationViewModel = AuthenticationViewModel()
  var body: some Scene {
    WindowGroup {
      NavigationStack {
          LoginView()
              .environmentObject(authenticationViewModel)
      }
      .environmentObject(authenticationViewModel)
    }
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
