//
//  AppView.swift
//  HealthyHome
//
//  Created by Fred on 31/05/2025.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var selectedLocationManager = SelectedLocationManager()
    @StateObject var locationVM = LocationsViewModel()
    @StateObject var tasksVM = TasksViewModel()
    @State private var selectedTab: Int = 0
    
    var body: some View {
        
            if authVM.isLoggedIn {
                Navigation(selectedTab: $selectedTab)
                    .environmentObject(authVM)
                    .environmentObject(selectedLocationManager)
                    .environmentObject(locationVM)
                    .environmentObject(tasksVM)
                    
            } else {
                LoginView(authVM: authVM, locationVM: locationVM, selectedTab: $selectedTab)
            }
        
    }
}

#Preview {
    AppView()
}
 
