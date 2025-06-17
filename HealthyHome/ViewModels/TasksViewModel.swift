//
//  TasksViewModel.swift
//  HealthyHome
//
//  Created by Fred on 09/06/2025.
//

import Foundation
import FirebaseFirestore

class TasksViewModel: ObservableObject {
    
    @Published var tasks: [Task] = []
    private var db = Firestore.firestore()
    
    func fetchTasks(for userID: String, locationID: String) {
    
        db.collection("users").document(userID)
            .collection("locations").document(locationID)
            .collection("tasks")
            .order(by: "dueDate", descending: false)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("No task found")
                    return
                }
                
                self.tasks = documents.compactMap { doc in
                    try? doc.data(as: Task.self)
                }
            }
    }
    
    func addTask(_ task: Task, to userID: String, locationID: String) {
        do {
            let ref = try db.collection("users").document(userID)
                .collection("locations").document(locationID)
                .collection("tasks")
                .addDocument(from: task)
            print("Wrote task to: \(ref.path)")
            } catch {
                print("Failedd to add task: \(error.localizedDescription)")
        }
    }
    
    func deleteTask(_ task: Task, from userID: String, locationID: String) {
        guard let taskID = task.id else { return }
        db.collection("users").document(userID)
            .collection("locations").document(locationID)
            .collection("tasks").document(taskID)
            .delete()
    }
    
    func updateTask(_ task: Task, from userID: String, locationID: String) {
        guard let taskID = task.id else { return }
        do {
            try db.collection("users").document(userID)
                .collection("locations").document(locationID)
                .collection("tasks").document(taskID)
                .setData(from: task)
        }
        catch {
            print("Failed to update task: \(error.localizedDescription)")
        }
    }
}
