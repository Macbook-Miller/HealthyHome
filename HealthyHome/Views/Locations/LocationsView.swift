//
//  LocationsView.swift
//  HealthyHome
//
//  Created by Fred on 30/05/2025.
//

import SwiftUI

struct LocationsView: View {
    
    @State private var showCreateLocation = false
    @StateObject private var locationsVM = LocationsViewModel()
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            Text("Select location")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.horizontal)

            ScrollView {
                VStack(spacing: 20) {
                    ForEach(locationsVM.locations) { location in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(location.type)
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(location.address)
                                .font(.title3)
                                .fontWeight(.semibold)

                            // Simulated progress bar
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(height: 6)
                                    .foregroundColor(Color.gray.opacity(0.3))
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(width: 150, height: 6) // Replace 150 with calculated width
                                    .foregroundColor(.black)
                            }

                            HStack {
                                Text("Type: \(location.type)")
                                Spacer()
                                Text("Rooms: \(location.rooms)")
                            }
                            .font(.caption)

                            HStack {
                                Text("Tasks: 0") // Placeholder
                                Spacer()
                                Text("Members: \(location.members)")
                            }
                            .font(.caption)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                    }
                }
            }
            
            VStack {
                Button(action: {
                    showCreateLocation = true
                }) {
                    Text("Create new")
                        .foregroundColor(Color.white)
                        .padding()
                        .frame(maxWidth: 120)
                        .background(Color("BtnBlack"))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 20)
        }
        .backgroundGradient()
        .sheet(isPresented: $showCreateLocation) {
            CreateLocationSheet()
                .environmentObject(authVM)
        }
        .onAppear {
            if let uid = authVM.user?.uid {
                locationsVM.fetchLocations(for: uid)
            }
        }
    }
    
}

#Preview {
    LocationsView()
}
