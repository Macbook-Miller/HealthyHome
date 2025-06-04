//
//  Navigation.swift
//  HealthyHome
//
//  Created by Fred on 04/06/2025.
//

import SwiftUI

struct Navigation: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        
        TabView {
            
            HomeView()
                .environmentObject(authVM)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            LocationsView()
                .environmentObject(authVM)
                .tabItem {
                    Image(systemName: "map")
                    Text("Locations")
                }
            
            TasksView()
                .environmentObject(authVM)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Tasks")
                }
            
            SettingsView()
                .environmentObject(authVM)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .accentColor(Color("BtnBlack"))
    }
}

#Preview {
    Navigation()
        .environmentObject(AuthViewModel())
}
