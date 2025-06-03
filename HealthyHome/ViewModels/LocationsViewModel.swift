//
//  LocationsViewModel.swift
//  HealthyHome
//
//  Created by Fred on 03/06/2025.
//

import Foundation
import FirebaseFirestore

class LocationsViewModel: ObservableObject {
    let db = Firestore.firestore()
    
    func createLocation(for uid: String, location: Location) {
        db.collection("users")
            .document(uid)
            .collection("locations")
            .document(location.id)
            .setData([
                "address": location.address,
                "sqm": location.sqm,
                "rooms": location.rooms,
                "type": location.type,
                "members": location.members
            ]) { error in
                if let error = error {
                    print("Error creating location: \(error.localizedDescription)")
                }
                else {
                    print("Location created succesful")
                }
            }
    }
}
