//
//  ForgotPasswordView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 22/05/2023.
//

import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State private var email = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.presentationMode) var presentationMode
    
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.showAlert = true
                self.alertMessage = error.localizedDescription
            } else {
                self.showAlert = true
                self.alertMessage = "Se ha enviado un correo electrónico para restablecer la contraseña"
            }
        }
    }
    
    var body: some View {
        NavigationStack  {
            
        }
    }
}


struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
