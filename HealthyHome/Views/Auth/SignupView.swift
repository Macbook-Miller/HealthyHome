//
//  SignupView.swift
//  HealthyHome
//
//  Created by Fred on 30/05/2025.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var authVM: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(\.dismiss) var dismiss // For going back
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Create a HealthyHome Account")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            
            
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
            }
            
            if let error = authVM.authError {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
            }
            
            
            Button(action: {
                authVM.signup(email: email, password: password)
            }) {
                Text("Sign-up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            
            Button("Already have an account? Log in here") {
                dismiss()
            }
            .font(.footnote)
            .foregroundColor(.gray)
            
        }
        .padding()
    }
    
}

#Preview {
    SignupView(authVM: AuthViewModel())
}
