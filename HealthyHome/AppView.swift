//
//  AppView.swift
//  HealthyHome
//
//  Created by Fred on 31/05/2025.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        Group {
            if authVM.isLoggedIn {
                HomeView()
            } else {
                LoginView(authVM: authVM)
            }
        }
    }
}

#Preview {
    AppView()
}
 
