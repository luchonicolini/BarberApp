//
//  LoginView.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 22/05/2023.
//

import SwiftUI
import Combine


private enum FocusableField: Hashable {
    case email
    case password
}

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    @State private var navigateToHome = false
    @FocusState private var focus: FocusableField?
    
    private func signInWithEmailLink() {
        Task {
            await viewModel.sendSignInLink()
            dismiss()
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    Image("logo1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minHeight: 300, maxHeight: 400)
                    Text("Iniciar sesión")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Image(systemName: "at")
                        TextField("Email", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .focused($focus, equals: .email)
                            .onSubmit {
                                signInWithEmailLink()
                            }
                    }
                    .padding(.vertical, 6)
                    .background(Divider(), alignment: .bottom)
                    .padding(.bottom, 4)
                    
                    HStack {
                        Image(systemName: "lock")
                        SecureField("Password", text: $viewModel.password)
                            .focused($focus, equals: .password)
                    }
                    .padding(.vertical, 6)
                    .background(Divider(), alignment: .bottom)
                    .padding(.bottom, 4)
                    
                    if !viewModel.errorMessage.isEmpty {
                        VStack {
                            Text(viewModel.errorMessage)
                                .font(.caption)
                                .foregroundColor(Color(UIColor.systemRed))
                        }
                    }
                    
                    Button(action: {
                        viewModel.login { success in
                            if success {
                                dismiss()
                                navigateToHome = true
                            }
                        }
                    }) {
                        if viewModel.authenticationState != .authenticating {
                            Text("Iniciar sesión")
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
                        Text("¿No tienes una cuenta?")
                        NavigationLink(destination: SignupView()) {
                            Text("Regístrate")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                        }
                    }
                }
                .onAppear {
                    viewModel.resetFields() 
                }
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
            }
            .listStyle(.plain)
            .padding()
        }
        //.background(
           // NavigationLink(destination: HomeView()) {
           //     EmptyView()
         //   }
       // )
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(AuthenticationViewModel())
    }
}

