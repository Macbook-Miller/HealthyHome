//
//  NewTaskSheet.swift
//  HealthyHome
//
//  Created by Fred on 30/05/2025.
//

import SwiftUI

struct NewTaskSheet: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var taskVM: TasksViewModel
    let locationID: String
    
    @State private var title: String = ""
    @State private var dueDate: Date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $title)
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                }
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        guard !locationID.isEmpty else {
                            print("Location ID is empty")
                            return
                        }
                        guard let userID = authVM.user?.uid else {
                            print("User ID not found..")
                            return
                        }
                        
                        let newTask = Task(
                            title: title,
                            dueDate: dueDate,
                            isCompleted: false,
                            locationID: locationID
                        )
                        taskVM.addTask(newTask, to: userID, locationID: locationID)
                        dismiss()
                        
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}


