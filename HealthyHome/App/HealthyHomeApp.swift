//
//  HealthyHomeApp.swift
//  HealthyHome
//
//  Created by Fred on 26/05/2025.
//

import SwiftUI
import Firebase

@main
struct HealthyHomeApp: App {
    @StateObject var authVM = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(authVM)
        }
    }
}
