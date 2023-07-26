//
//  ForgotPasswordView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 22/05/2023.
//

import SwiftUI
import FirebaseAuth

import SwiftUI
import Firebase

struct ForgotPasswordView: View {
    @State private var email = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.presentationMode) var presentationMode
    
    func isValid(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func resetPassword() {
        if isValid(email: email) {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    self.showAlert = true
                    self.alertMessage = error.localizedDescription
                } else {
                    self.showAlert = true
                    self.alertMessage = "Se ha enviado un correo electrónico para restablecer la contraseña"
                }
            }
        } else {
            self.alertMessage = "Por favor, introduce un correo electrónico válido."
            self.showAlert = true
        }
    }
    
    var body: some View {
        NavigationStack  {
            VStack(spacing: 20) {
                Image("logo1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minHeight: 150, maxHeight: 250)
                    .padding(.top, 20)
                
                Text("Recuperar contraseña")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Introduce tu dirección de correo electrónico y te enviaremos un enlace para restablecer tu contraseña.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                HStack {
                    Image(systemName: "at")
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 10)
                }
                .padding(.top, 20)
                
                Button(action: resetPassword) {
                    Text("Enviar enlace")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .padding(.horizontal)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Información"), message: Text(alertMessage), dismissButton: .default(Text("Ok"), action: {
                    if alertMessage == "Se ha enviado un correo electrónico para restablecer la contraseña" {
                        presentationMode.wrappedValue.dismiss()
                    }
                }))
            }
        }
    }
}




struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
