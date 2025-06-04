//
//  CreateLocationSheet.swift
//  HealthyHome
//
//  Created by Fred on 03/06/2025.
//

import SwiftUI

struct CreateLocationSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var locationsVM = LocationsViewModel()
    
    @State private var address: String = ""
    @State private var sqm: String = ""
    @State private var rooms: String = ""
    @State private var type: String = "Home"
    @State private var members: Int = 1
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Location Info")) {
                    TextField("Address", text: $address)
                    TextField("Square Meters", text: $sqm)
                        .keyboardType(.numberPad)
                    TextField("Rooms", text: $rooms)
                        .keyboardType(.numberPad)
                    Picker("Type", selection: $type) {
                        Text("Home").tag("Home")
                        Text("Vacation Home").tag("Vacation Home")
                        Text("Apartment").tag("Apartment")
                    }
                    .pickerStyle(.menu)
                    HStack {
                        Text("Members")
                        Spacer()
                        Text("\(members)")
                            
                    }
                    .foregroundColor(.gray)
                }

                Button(action: {
                    print("Tapped Create Location")
                    guard let uid = authVM.user?.uid else {
                        print("No user UID found.")
                        return
                    }
                    print("UID found: \(uid)")

                    let location = Location(
                        id: UUID().uuidString,
                        address: address,
                        sqm: Int(sqm) ?? 0,
                        rooms: Int(rooms) ?? 0,
                        type: type,
                        members: Int(members)
                    )
                    print("Creating location with address: \(address)")

                    locationsVM.createLocation(for: uid, location: location)
                    dismiss()
                }) {
                    Text("Create Location")
                        .foregroundColor(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("BtnBlack"))
                        .cornerRadius(8)
                }
            }
            .navigationTitle("New Location")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    CreateLocationSheet()
        .environmentObject(AuthViewModel())
}
