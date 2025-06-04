//
//  LocationsViewModel.swift
//  HealthyHome
//
//  Created by Fred on 03/06/2025.
//

import Foundation
import FirebaseFirestore

class LocationsViewModel: ObservableObject {
    @Published var locations: [Location] = []
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

    func fetchLocations(for uid: String) {
        db.collection("users")
            .document(uid)
            .collection("locations")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching locations: \(error.localizedDescription)")
                    return
                }

                guard let documents = snapshot?.documents else {
                    print("No documents found.")
                    return
                }

                self.locations = documents.compactMap { doc in
                    let data = doc.data()
                    return Location(
                        id: doc.documentID,
                        address: data["address"] as? String ?? "",
                        sqm: data["sqm"] as? Int ?? 0,
                        rooms: data["rooms"] as? Int ?? 0,
                        type: data["type"] as? String ?? "",
                        members: data["members"] as? Int ?? 1
                    )
                }
            }
    }
}
