//
//  TasksView.swift
//  HealthyHome
//
//  Created by Fred on 30/05/2025.
//

import SwiftUI


struct TasksView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @State private var showCreateTaskSheet = false
    
    let locationID: String
    @StateObject private var tasksVM: TasksViewModel

    init(locationID: String, tasksVM: TasksViewModel = TasksViewModel()) {
        self.locationID = locationID
        _tasksVM = StateObject(wrappedValue: tasksVM)
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        
        VStack {
           
            if tasksVM.tasks.isEmpty {
                Text("No tasks yet.")
                    .foregroundColor(.gray)
                    .padding()
            }
            else {
                List {
                    ForEach(tasksVM.tasks) { task in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .font(.headline)
                                    .strikethrough(task.isCompleted, color: .gray)
                                Text("Due: \(task.dueDate, formatter: dateFormatter)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            if task.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                            
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            var updatedTask = task
                            updatedTask.isCompleted.toggle()
                            if let userID = authVM.user?.uid {
                                tasksVM.updateTask(updatedTask, from: userID, locationID: locationID)
                            }
                            
                        }
                        
                        
                        
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                        let task = tasksVM.tasks[index]
                        if let userID = authVM.user?.uid {
                            tasksVM.deleteTask(task, from: userID, locationID: locationID)
                        }
                        
                        }
                    }
                    
                }.listStyle(.insetGrouped)
            }
            
            Button(action: {
                showCreateTaskSheet = true
            }) {
                Text("New Task")
                    .foregroundColor(Color("BoxColor"))
                    .padding()
                    .frame(maxWidth: 220)
                    .background(Color("BtnBlack"))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            if !locationID.isEmpty, let userID = authVM.user?.uid {
                tasksVM.fetchTasks(for: userID, locationID: locationID)
            }
        }
        .sheet(isPresented: $showCreateTaskSheet) {
            NewTaskSheet(taskVM: tasksVM, locationID: locationID)
                
        }
        
        
    }
}

