//
//  LocationsViewModel.swift
//  HealthyHome
//
//  Created by Fred on 03/06/2025.
//

import Foundation
import FirebaseFirestore

class LocationsViewModel: ObservableObject {
    let uuid = UUID()
    @Published var locations: [Location] = []
    @Published var taskCounts: [String: Int] = [:]
    @Published var pendingTaskCount: [String: Int] = [:]
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

    func fetchLocations(for uid: String, completion: @escaping ([Location]) -> Void) {
        print("fetchLocations called with uid: \(self.uuid)")
        db.collection("users")
            .document(uid)
            .collection("locations")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching locations: \(error.localizedDescription)")
                    completion([])
                    return
                }

                guard let documents = snapshot?.documents else {
                    print("No documents found.")
                    completion([])
                    return
                }

                let locations = documents.compactMap { doc in
                    
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
                print("Fetched locations: \(locations.map {$0.address })")
                
                // Always update the published property for the UI.
                DispatchQueue.main.async {
                    self.locations = locations
                }
                
                completion(locations)
            }
    }
    
    func deleteLocation(_ location: Location, for uid: String) {
        db.collection("users")
            .document(uid)
            .collection("locations")
            .document(location.id)
            .delete { error in
                if let error = error {
                    print("Error deleting location: \(error)")
                }
                else {
                    DispatchQueue.main.async {
                        self.locations.removeAll { $0.id == location.id }
                    }
                }
            }
    }
    
    func fetchTaskCount(for uid: String, locationID: String) {
        let ref = db.collection("users").document(uid)
            .collection("locations").document(locationID)
            .collection("tasks")
        ref.getDocuments { snapshot, error in
            DispatchQueue.main.async {
                self.taskCounts[locationID] = snapshot?.count ?? 0
            }
        }
    }
    
    func fetchPendingTaskCount(for uid: String, locationID: String) {
        let ref = db.collection("users").document(uid)
            .collection("locations").document(locationID)
            .collection("tasks")
        ref.getDocuments { snapshot, error in
            guard let docs = snapshot?.documents else {
                DispatchQueue.main.async {
                    self.pendingTaskCount[locationID] = 0
                }
                return
            }
            let now = Date()
            let count = docs.reduce(0) { partialResult, doc in
                if let timestamp = doc.data()["dueDate"] as? Timestamp {
                    let dueDate = timestamp.dateValue()
                    return dueDate < now ? partialResult + 1 : partialResult
                }
                return partialResult
            }
            DispatchQueue.main.async {
                self.pendingTaskCount[locationID] = count
            }
        }
    }
}
