//
//  LoginView.swift
//  HealthyHome
//
//  Created by Fred on 30/05/2025.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authVM: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showSignup = false
    @State private var forgotPass = false
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Login")
                .font(.title)
                .fontWeight(.bold)
                
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
            
            
            HStack {
                Button(action: {
                    authVM.login(email: email, password: password)
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("BtnBlack"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                
                // Opens my sheet for signingup
                Button(action:  {
                    showSignup = true
                } ) {
                    Text("Sign-up")
                        .foregroundColor(.accentColor)
                        
                }
            }
            
            
            Button("Forgot password") {
                forgotPass = true
            }
        }
        .padding(.horizontal, 20)
        .backgroundGradient()
        .sheet(isPresented: $showSignup) {
            SignupView(authVM: authVM)
        }
        .sheet(isPresented: $forgotPass) {
            ResetPasswordSheet()
        }
    }
}

#Preview {
    LoginView(authVM: AuthViewModel())
}
