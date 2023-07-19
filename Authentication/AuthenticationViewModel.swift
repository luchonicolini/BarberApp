//
//  AuthViewModel.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 22/05/2023.
//

import Firebase
import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

enum AuthenticationState {
  case unauthenticated
  case authenticating
  case authenticated
}

enum AuthenticationFlow {
  case login
  case signUp
}

@MainActor
class AuthenticationViewModel: ObservableObject {
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var confirmPassword: String = ""

  @Published var flow: AuthenticationFlow = .login

  @Published var isValid: Bool  = false
  @Published var authenticationState: AuthenticationState = .unauthenticated
  @Published var errorMessage: String = ""
  @Published var user: User?
  @Published var displayName: String = ""
    
    let passwordRequirementsMessage = "La contraseña debe tener al menos 6 caracteres y contener al menos un número."
    let invalidEmailMessage = "Ingresa un correo válido."

  init() {
    registerAuthStateHandler()

    $flow
      .combineLatest($email, $password, $confirmPassword)
      .map { flow, email, password, confirmPassword in
        flow == .login
        ? !(email.isEmpty || password.isEmpty)
        : !(email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
      }
      .assign(to: &$isValid)
  }

  private var authStateHandler: AuthStateDidChangeListenerHandle?

  func registerAuthStateHandler() {
    if authStateHandler == nil {
      authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
        self.user = user
        self.authenticationState = user == nil ? .unauthenticated : .authenticated
        self.displayName = user?.email ?? ""
      }
    }
  }

  func switchFlow() {
    flow = flow == .login ? .signUp : .login
    errorMessage = ""
  }

  private func wait() async {
    do {
      print("Wait")
      try await Task.sleep(nanoseconds: 1_000_000_000)
      print("Done")
    }
    catch { print(error.localizedDescription) }
  }

  func reset() {
    flow = .login
    email = ""
    password = ""
    confirmPassword = ""
    errorMessage = ""
  }
}

extension AuthenticationViewModel {
    // MARK: - Login
    
    func login(completion: @escaping (Bool) -> Void) {
        authenticationState = .authenticating
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.authenticationState = .unauthenticated
                completion(false)
            } else {
                guard let user = Auth.auth().currentUser else {
                    self.authenticationState = .unauthenticated
                    completion(false)
                    return
                }
                
                if !user.isEmailVerified {
                    self.errorMessage = "Por favor, verifica tu dirección de correo electrónico antes de iniciar sesión."
                    self.authenticationState = .unauthenticated
                    completion(false)
                } else {
                    self.authenticationState = .authenticated
                    self.email = ""
                    self.password = ""
                    completion(true)
                }
            }
        }
    }

   
    // MARK: - resendEmailVerification
    
    func resendEmailVerification() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        user.sendEmailVerification { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.errorMessage = "Se ha enviado un nuevo correo de verificación."
            }
        }
    }


    
    // MARK: - Register
    
    func register(completion: @escaping (Bool) -> Void) {
        authenticationState = .authenticating
        
        guard password == confirmPassword else {
            errorMessage = "Las contraseñas no coinciden"
            authenticationState = .unauthenticated
            completion(false)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            self.authenticationState = .unauthenticated
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion(false)
                return
            }
            
            guard let user = result?.user else {
                completion(false)
                return
            }
            
            self.sendEmailVerification(for: user, completion: completion)
        }
    }

    
    // MARK: - Email Verification
    
    private func sendEmailVerification(for user: User, completion: @escaping (Bool) -> Void) {
        user.sendEmailVerification { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.signOut()
                self.authenticationState = .unauthenticated
                completion(false)
                return
            }
            
            self.authenticationState = .authenticated
            completion(true)
        }
    }
    
    // MARK: - Sign Out
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Delete Account
    
    func deleteAccount() async -> Bool {
        do {
            try await user?.delete()
            return true
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    // MARK: - Validation
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[0-9]).{6,}$"
        let isValid = NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
        if !isValid {
            errorMessage = passwordRequirementsMessage
        }
        return isValid
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let isValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        if !isValid {
            errorMessage = invalidEmailMessage
        }
        return isValid
    }
}




// MARK: - Google Sign-In

enum AuthenticationError: Error {
  case tokenError(message: String)
}

extension AuthenticationViewModel {
  func signInWithGoogle() async -> Bool {
    guard let clientID = FirebaseApp.app()?.options.clientID else {
      fatalError("No client ID found in Firebase configuration")
    }
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = config

    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first,
          let rootViewController = window.rootViewController else {
      print("There is no root view controller!")
      return false
    }

      do {
        let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)

        let user = userAuthentication.user
        guard let idToken = user.idToken else { throw AuthenticationError.tokenError(message: "ID token missing") }
        let accessToken = user.accessToken

        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                       accessToken: accessToken.tokenString)

        let result = try await Auth.auth().signIn(with: credential)
        let firebaseUser = result.user
        print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
        return true
      }
      catch {
        print(error.localizedDescription)
        self.errorMessage = error.localizedDescription
        return false
      }
  }
}
