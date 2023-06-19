//
//  AuthViewModel.swift
//  AplicacionBarber
//
//  Created by Luciano Nicolini on 22/05/2023.
//

import SwiftUI
import FirebaseAuth

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

enum AuthenticationFlow {
    case login
    case signUp
}

enum EmailLinkStatus {
    case none
    case pending
}

@MainActor
class AuthenticationViewModel: ObservableObject {
    @AppStorage("email-link") var emailLink: String?
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    
    @Published var flow: AuthenticationFlow = .login
    
    @Published var isValid  = false
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var errorMessage = ""
    @Published var user: User?
    @Published var displayName = ""
    
    @Published var isGuestUser = false
    @Published var isVerified = false
    @Published var registrationSuccessful = false
    
    func resetFields() {
        email = ""
        password = ""
        confirmPassword = ""
    }
    
    // MARK: - login
    func login(completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion(false)
            } else {
                let user = Auth.auth().currentUser
                if !user!.isEmailVerified {
                    self.errorMessage = "Please verify your email address before logging in."
                    self.signOut()
                    completion(false)
                } else {
                    self.authenticationState = .authenticated
                    completion(true)
                }
            }
        }
    }
    
    // MARK: - EmailVerification
    func sendEmailVerification() async {
        guard let user = Auth.auth().currentUser else { return }
        
        do {
            try await user.sendEmailVerification()
            // Aquí puedes realizar alguna acción adicional después de enviar el correo de verificación, si es necesario
        } catch {
            print(error.localizedDescription)
            // Maneja el error de envío de correo de verificación, si es necesario
        }
    }
    
    func isEmailVerified() -> Bool {
        return user?.isEmailVerified ?? false
    }
    
    // MARK: - The email address is already in use by another account
    func signUpWithEmailPassword() {
        Task {
            do {
                // Mostrar indicador de carga
                authenticationState = .authenticating
                
                // Validar el formato del email
                guard isValidEmail(email) else {
                    errorMessage = "Ingresa un correo válido"
                    authenticationState = .unauthenticated
                    return
                }
                
                // Validar la fortaleza de la contraseña
                guard isValidPassword(password) else {
                    errorMessage = "La contraseña debe tener al menos 6 caracteres y contener al menos un número"
                    authenticationState = .unauthenticated
                    return
                }
                
                // Verificar que las contraseñas coincidan
                guard password == confirmPassword else {
                    errorMessage = "Las contraseñas no coinciden"
                    authenticationState = .unauthenticated
                    return
                }
                
                // Registrar usuario con correo electrónico y contraseña
                let result = try await Auth.auth().createUser(withEmail: email, password: password)
                let user = result.user
                
                // Actualizar propiedades y estado de autenticación
                self.user = user
                authenticationState = .authenticated
                displayName = user.email ?? ""
                
                // Limpiar campos y mostrar mensaje de éxito si es necesario
                email = ""
                password = ""
                confirmPassword = ""
                errorMessage = ""
                
                // Envía un correo electrónico de verificación si es necesario
                if !user.isEmailVerified {
                    try await user.sendEmailVerification()
                }
            } catch {
                // Mostrar mensaje de error en caso de fallo
                errorMessage = error.localizedDescription
                authenticationState = .unauthenticated
            }
            
            // Ocultar indicador de carga
            authenticationState = .unauthenticated
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = #"^(?=.*[0-9]).{6,}$"#
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    init() {
        registerAuthStateHandler()
        
        $email
            .map { email in
                !email.isEmpty
            }
            .assign(to: &$isValid)
        
        $user
            .compactMap { user in
                user?.isAnonymous
            }
            .assign(to: &$isGuestUser)
        
        $user
            .compactMap { user in
                user?.isEmailVerified
            }
            .assign(to: &$isVerified)
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
        catch {
            print(error.localizedDescription)
        }
    }
    
    func reset() {
        flow = .login
        email = ""
        emailLink = nil
        errorMessage = ""
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
}

// MARK: - Email and Link Authentication
extension AuthenticationViewModel {
    func sendSignInLink() async {
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.url = URL(string: "https://favourites.page.link/email-link-login")
        
        do {
            try await Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings)
            emailLink = email
        }
        catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
    
    var emailLinkStatus: EmailLinkStatus {
        emailLink == nil ? .none : .pending
    }
    
    func handleSignInLink(_ url: URL) async {
        guard let email = emailLink else {
            errorMessage = "Invalid email address. Most likely, the link you used has expired. Try signing in again."
            return
        }
        let link = url.absoluteString
        if Auth.auth().isSignIn(withEmailLink: link) {
            do {
                let result = try await Auth.auth().signIn(withEmail: email, link: link)
                let user = result.user
                print("User \(user.uid) signed in with email \(user.email ?? "(unknown)"). The email is \(user.isEmailVerified ? "" : "NOT") verified")
                emailLink = nil
            }
            catch {
                print(error.localizedDescription)
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
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
}
