//
//  ResetPasswordSheet.swift
//  HealthyHome
//
//  Created by Fred on 31/05/2025.
//

import SwiftUI
import FirebaseAuth

struct ResetPasswordSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var email: String = ""
    @State private var message: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Reset password")
                .font(.title)
                .bold()
            
            TextField("Enter your email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)
            
            Button("Send reset email") {
                guard !email.isEmpty else {
                    message = "Please enter your email!"
                    return
                }
                
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        message = error.localizedDescription
                    } else {
                        message = "Reset link sent! Check your inbox."
                    }
                }
            }
            
            Button("back") {
                dismiss()
            }
        }
        .padding()
    }
}

#Preview {
    ResetPasswordSheet()
}
