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
    
    private func signUpWithEmailPassword() {
        Task {
            viewModel.signUpWithEmailPassword()
            await viewModel.sendEmailVerification()
            
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image("logo1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minHeight: 300, maxHeight: 400)
                    Text("Registrarse")
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
                            Text("Registrarse")
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                        } else {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .disabled(!viewModel.isValid)
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    
                    HStack {
                        Text("¿Ya tienes una cuenta?")
                        NavigationLink(destination: LoginView()) {
                            Text("Iniciar sesión")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                        }
                    }
                    .onAppear {
                        viewModel.resetFields()
                    }
                    //.padding([.top, .bottom], 50)
                    .padding(.top, 20)
                    .padding(.bottom, 8)
                    
                }
                .listStyle(.plain)
                .padding()
            }
        }
        .alert(isPresented: $viewModel.registrationSuccessful) {
            Alert(title: Text("Registro Exitoso"),
                  message: Text("Se ha enviado un correo electrónico para verificar su cuenta."),
                  dismissButton: .default(Text("Ok"), action: {
                dismiss()
            }))
        }
        .onReceive(viewModel.$isVerified) { isVerified in
            if isVerified {
                viewModel.registrationSuccessful = true
            }
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



