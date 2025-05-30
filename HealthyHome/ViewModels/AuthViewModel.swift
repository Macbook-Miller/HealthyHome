//
//  AuthViewModel.swift
//  HealthyHome
//
//  Created by Fred on 29/05/2025.
//

import Foundation
import FirebaseAuth

// Class for managing everythingg related to Authentication.
class AuthViewModel: ObservableObject {
    //Login state saved here:
    @Published var isLoggedIn: Bool = false
    @Published var authError: String?
    
    init() {
        // This is a firebase auth feature that returns the currently logged in user, if there is one.
        self.isLoggedIn = Auth.auth().currentUser != nil
    }
    
    func login(email: String, password: String) {
        authError = nil // clearing any prev errors
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.authError = error.localizedDescription
                }
                else {
                    self.isLoggedIn = true
                }
            }
        }
    }
    
    
    func signup(email: String, password: String) {
        authError = nil // clearing any prev errors
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.authError = error.localizedDescription
                }
                else {
                    self.isLoggedIn = true
                    // TODO: Add Firestore user creation
                    
                }
            }
        }
            
        
    }
    
    
}
