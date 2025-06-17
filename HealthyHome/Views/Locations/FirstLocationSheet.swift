//
//  FirstLocationSheet.swift
//  HealthyHome
//
//  Created by Fred on 13/06/2025.
//

import SwiftUI

struct FirstLocationSheet: View {
    
    @ObservedObject var locationsVM: LocationsViewModel
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var address: String = ""
    @State private var sqm: String = ""
    @State private var rooms: String = ""
    @State private var type: String = "Home"
    let typeOptions = ["Home", "Vacation Home", "Apartment"]
   
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Location Details")) {
                    TextField("Address", text: $address)
                    TextField("Square Meters", text: $sqm)
                        .keyboardType(.numberPad)
                    TextField("Number of Rooms", text: $rooms)
                        .keyboardType(.numberPad)
                    Picker("Type", selection: $type) {
                        ForEach(typeOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                }
            }
            .navigationTitle("Create Your First Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        guard let uid = authVM.user?.uid else { return }
                        
                        let location = Location (
                            id: UUID().uuidString,
                            address: address,
                            sqm: Int(sqm) ?? 0,
                            rooms: Int(rooms) ?? 0,
                            type: type,
                            members: 1
                        )
                        locationsVM.createLocation(for: uid, location: location)
                        dismiss()
                    }
                    .disabled(address.isEmpty || sqm.isEmpty || rooms.isEmpty)
                }
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
    FirstLocationSheet(
        locationsVM: LocationsViewModel()
    )
    .environmentObject(AuthViewModel())
}
