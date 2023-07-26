//
//  RegistrationView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 22/05/2023.
//

import SwiftUI
import Combine

private enum FocusableField: Hashable {
    case email
    case password
    case confirmPassword
}

struct SignupView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var focus: FocusableField?
    @State private var registrationSuccessful = false
    
    private func signUpWithEmailPassword() {
        Task {
            viewModel.register { success in
                if success {
                    registrationSuccessful = true
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Image("logo1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    //.frame(minHeight: 300, maxHeight: 400)
                        .frame(minHeight: 200, maxHeight: 300)
                    Text("Sign up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Image(systemName: "at")
                        TextField("Email", text: $viewModel.email)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .focused($focus, equals: .email)
                            .submitLabel(.next)
                            .onSubmit {
                                self.focus = .password
                            }
                            .accessibilityLabel("Email") // Etiqueta de accesibilidad
                    }
                    .padding(.vertical, 6)
                    .background(Divider(), alignment: .bottom)
                    .padding(.bottom, 4)
                    
                    HStack {
                        Image(systemName: "lock")
                        SecureField("Password", text: $viewModel.password)
                            .focused($focus, equals: .password)
                            .submitLabel(.next)
                            .onSubmit {
                                self.focus = .confirmPassword
                            }
                            .accessibilityLabel("Contraseña") // Etiqueta de accesibilidad
                    }
                    .padding(.vertical, 6)
                    .background(Divider(), alignment: .bottom)
                    .padding(.bottom, 8)
                    
                    HStack {
                        Image(systemName: "lock")
                        SecureField("Confirm password", text: $viewModel.confirmPassword)
                            .focused($focus, equals: .confirmPassword)
                            .submitLabel(.go)
                            .onSubmit {
                                signUpWithEmailPassword()
                            }
                            .accessibilityLabel("Confirmar contraseña") // Etiqueta de accesibilidad
                    }
                    .padding(.vertical, 6)
                    .background(Divider(), alignment: .bottom)
                    .padding(.bottom, 8)
                    
                    
                    if !viewModel.errorMessage.isEmpty {
                        VStack {
                            Text(viewModel.errorMessage)
                                .font(.caption)
                                .foregroundColor(Color(UIColor.systemRed))
                        }
                    }
                    
                    Button(action: signUpWithEmailPassword) {
                        if viewModel.authenticationState != .authenticating {
                            Text("Sign up")
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                        }
                        else {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .disabled(!viewModel.isValid)
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    .accessibilityLabel(viewModel.authenticationState != .authenticating ? "Registrarse" : "Cargando") // Etiqueta de accesibilidad
                    
                    VStack(spacing: 6) {
                        HStack {
                            Text("¿Ya tienes una cuenta?")
                                .multilineTextAlignment(.center)
                            NavigationLink(destination: LoginView()) {
                                Text("Iniciar sesión")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        HStack {
                            Text("¿Olvidaste tu contraseña?")
                                .multilineTextAlignment(.center)
                            NavigationLink(destination: ForgotPasswordView()) {
                                Text("Recuperar")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)

                    
                }
                .onAppear {
                    viewModel.reset()
                }
            }
            
            .listStyle(.plain)
            .padding()
        }
        .alert(isPresented: $registrationSuccessful) {
            Alert(title: Text("Registro Exitoso"),
                  message: Text("Se ha enviado un correo electrónico para verificar su cuenta."),
                  dismissButton: .default(Text("Ok"), action: {
                dismiss()
            }))
        }
    }
}



struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignupView()
                .preferredColorScheme(.dark)
                .environmentObject(AuthenticationViewModel())
        }
    }
}



