//
//  Navigation.swift
//  HealthyHome
//
//  Created by Fred on 04/06/2025.
//

import SwiftUI

struct Navigation: View {
    @Binding var selectedTab: Int
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var selectedLocationManager: SelectedLocationManager
    @EnvironmentObject var locationVM: LocationsViewModel
    @EnvironmentObject var tasksVM: TasksViewModel
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            HomeView(selectedTab: $selectedTab)
                .environmentObject(authVM)
                .environmentObject(locationVM)
                .environmentObject(selectedLocationManager)
                .environmentObject(tasksVM)
                
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            LocationsView(selectedTab: $selectedTab)
                .environmentObject(authVM)
                .environmentObject(locationVM)
                .environmentObject(selectedLocationManager)
                .tabItem {
                    Image(systemName: "map")
                    Text("Locations")
                }
                .tag(1)
            
            TasksView(locationID: selectedLocationManager.locationID)
                .environmentObject(authVM)
                .environmentObject(locationVM)
                .environmentObject(selectedLocationManager)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Tasks")
                }
                .tag(2)
            
            SettingsView()
                .environmentObject(authVM)
                .environmentObject(locationVM)
                .environmentObject(selectedLocationManager)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(3)
        }
        .onChange(of: authVM.showSelectLocationTab) { _, shouldShow in
            print("onChange started, state of shouldShow is: \(shouldShow)")
            if shouldShow {
                print("Switching to location tab")
                selectedTab = 1 // FOr showing locations tab
                authVM.showSelectLocationTab = false
            }
        }
        .accentColor(Color("BtnBlack"))

    }
}

#Preview {
    Navigation(selectedTab: .constant(0))
        .environmentObject(AuthViewModel())
        .environmentObject(SelectedLocationManager())
        .environmentObject(LocationsViewModel())
        .environmentObject(TasksViewModel())
}
