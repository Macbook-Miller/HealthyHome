//
//  AuthViewModel.swift
//  HealthyHome
//
//  Created by Fred on 29/05/2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// Class for managing everythingg related to Authentication.
class AuthViewModel: ObservableObject {
    //Login state saved here:
    @Published var isLoggedIn: Bool = false
    @Published var authError: String?
    @Published var user: User? = nil
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        self.isLoggedIn = Auth.auth().currentUser != nil
        self.user = Auth.auth().currentUser
        
        authStateHandle = Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
            self.isLoggedIn = user != nil
        }
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
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let db = Firestore.firestore()
                    db.collection("users").document(uid).setData([
                        "email": email,
                        "createdAt" : Timestamp()
                    ]) { error in
                        if let error = error {
                            print("Error creating Firestore user doc: \(error.localizedDescription)")
                        } else {
                            print("User document created successfully in Firestore")
                        }}
                    
                    
                }
            }
            
            
        }
        
        
    }
    // Logout method
    func logout() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
