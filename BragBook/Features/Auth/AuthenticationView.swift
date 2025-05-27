//
//  AuthenticationView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/26/25.
//


import SwiftUI
import AuthenticationServices // For SignInWithAppleButton

struct AuthenticationView: View {
    @ObservedObject var authService: AuthenticationService

    var body: some View {
        VStack {
            Text("Welcome to BragBook")
                .font(.largeTitle)
                .padding(.bottom, 40)

            SignInWithAppleButton(
                .signIn, // .signUp or .continue
                onRequest: { request in
                    // You can modify the request here if needed, though often not necessary
                    // request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    switch result {
                    case .success(let authorization):
                        // This is handled by the AuthenticationService delegate methods
                        // authService.handleAuthorization(authorization)
                        // For this setup, the delegate in AuthenticationService will handle it.
                        // We call signInWithApple which triggers the delegate flow.
                        print("AuthenticationView: SignInWithAppleButton completed.")
                    case .failure(let error):
                        print("AuthenticationView: Sign in with Apple failed: \(error.localizedDescription)")
                        // Optionally update UI to show error
                    }
                }
            )
            .signInWithAppleButtonStyle(.black) // or .white or .whiteOutline
            .frame(width: 280, height: 45)
            .padding()

            // You could add more UI elements here, like "or sign in with email"
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(authService: AuthenticationService())
    }
}
