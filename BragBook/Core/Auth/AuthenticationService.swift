//
//  AuthenticationService.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/26/25.
//


import SwiftUI
import AuthenticationServices
import Combine // For ObservableObject

class AuthenticationService: NSObject, ObservableObject, ASAuthorizationControllerDelegate {
    @Published var isAuthenticated: Bool = false
    @Published var userId: String?
    // Add other relevant user details you might want to store

    func signInWithApple() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email] // You can request scopes

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        // For simulator, presentationContextProvider might not be strictly necessary
        // but good practice for physical devices.
        // authorizationController.presentationContextProvider = self 
        authorizationController.performRequests()
    }

    // ASAuthorizationControllerDelegate methods
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // For the purpose of this task, just print the user ID.
            // In a real app, you would securely store this, perhaps in Keychain.
            let userId = appleIDCredential.user
            print("Apple User ID: \(userId)")
            
            // You can also get fullName and email if requested and provided by user
            // let fullName = appleIDCredential.fullName
            // let email = appleIDCredential.email
            // print("User Name: \(fullName?.givenName ?? "") \(fullName?.familyName ?? "")")
            // print("User Email: \(email ?? "")")

            DispatchQueue.main.async {
                self.isAuthenticated = true
                self.userId = userId
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error
        print("Sign in with Apple failed: \(error.localizedDescription)")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
}

// If you need presentationContextProvider for physical devices:
/*
extension AuthenticationService: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // Return the window of your app
        // This requires access to the scene's window.
        // For simplicity, we'll assume this is handled or not strictly needed for simulator.
        // A common way is to pass it in or use a shared utility.
        guard let window = UIApplication.shared.connectedScenes
            .filter({-bash.activationState == .foregroundActive})
            .map({-bash as? UIWindowScene})
            .compactMap({-bash})
            .first?.windows
            .filter({-bash.isKeyWindow}).first else {
            // Fallback, though ideally you'd have a proper window reference.
            return ASPresentationAnchor() 
        }
        return window
    }
}
*/
