//
//  LoginView.swift
//  HealthyHome
//
//  Created by Fred on 30/05/2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var selectedLocationManager: SelectedLocationManager
    @ObservedObject var authVM: AuthViewModel
    @ObservedObject var locationVM: LocationsViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showSignup = false
    @State private var forgotPass = false
    @State private var showFirstLocationSheet = false
    @Binding var selectedTab: Int
    
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
                    authVM.login(email: email, password: password) { success in
                        if success, let uid = authVM.user?.uid {
                            locationVM.fetchLocations(for: uid) { locations in
                                DispatchQueue.main.async {
                                    print("Fetched locations after login", locations)
                                    if locations.isEmpty {
                                        selectedTab = 1
                                        showFirstLocationSheet = true
                                    }
                                    else if locations.count == 1 {
                                        selectedLocationManager.locationID = locations.first!.id
                                    }
                                    else {
                                        print("Setting showSelecLocationTab to true")
                                        authVM.showSelectLocationTab = true
                                    }
                                }
                            }
                        } else {
                            print("Login Error")
                        }
                    }
                    
                    
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
        .sheet(isPresented: $showFirstLocationSheet) {
            FirstLocationSheet(
                locationsVM: locationVM
            )
            .environmentObject(authVM)
        }
    }
}

#Preview {
    LoginView(
        authVM: AuthViewModel(),
        locationVM: LocationsViewModel(),
        selectedTab: .constant(0)
    )
    .environmentObject(SelectedLocationManager())
}
