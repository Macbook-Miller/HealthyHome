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
    @State private var type: String = ""
    @State private var members: String = ""
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Location Info")) {
                    TextField("Address", text: $address)
                    TextField("Square Meters", text: $sqm)
                        .keyboardType(.numberPad)
                    TextField("Rooms", text: $rooms)
                        .keyboardType(.numberPad)
                    TextField("Type", text: $type)
                    TextField("Members", text: $members)
                        .keyboardType(.numberPad)
                }

                Button(action: {
                    guard let uid = $authVM.user.uid else {
                        print("No user UID found.")
                        return
                    }

                    let location = Location(
                        id: UUID().uuidString,
                        address: address,
                        sqm: Int(sqm) ?? 0,
                        rooms: Int(rooms) ?? 0,
                        type: type,
                        members: Int(members) ?? 0
                    )

                    locationsVM.createLocation(for: uid, location: location)
                    dismiss()
                }) {
                    Text("Create Location")
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
