//
//  HomeView.swift
//  HealthyHome
//
//  Created by Fred on 30/05/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var selectedLocationManager: SelectedLocationManager
    @EnvironmentObject var locationsVM: LocationsViewModel
    @EnvironmentObject var tasksVM: TasksViewModel
    @Binding var selectedTab: Int
    
    var selectedLocation: Location? {
        let loc = locationsVM.locations.first(where: { $0.id == selectedLocationManager.locationID})
        print("HomeView: selectedLocation = \(loc?.address ?? "nil")")
        return loc
    }
    
    
    
    var body: some View {
        let locationID = selectedLocationManager.locationID
        let locationTasks = tasksVM.tasks.filter { $0.locationID == locationID }
        let healthPercent = locationTasks.healthPercentage
        let healthFraction = locationTasks.healthFraction
        
        VStack {
            
            
            
            HStack(alignment: .top) {
                
                VStack {
                    Text("\(healthPercent)%")
                        .font(.system(size: 68, weight: .light))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(.top, 60)
                
                
                VStack {
                    
                    Image("Clouds")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 150)
                        .offset(x: 25, y: -20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .frame(maxWidth: .infinity, maxHeight: 150)
            
            
            
            VStack(spacing: 0) {
                
                HStack(alignment: .bottom) {
                    
                    VStack(alignment: .leading) {
                        
                        Text("\(selectedLocation?.type ?? "-")")
                            .font(.system(size: 18, weight: .regular))
                            .opacity(0.3)
                        Text("\(selectedLocation?.address ?? "-")")
                            .font(.system(size: 22, weight: .semibold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    
                    Image(HouseImageHelper.imageName(for: healthPercent))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 160, height: 100)
                        .offset(y: 18)
                    
                }
                .frame(maxWidth: .infinity)
                
                
                
                VStack {
                    
                    ProgressView(value: healthFraction)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color("BtnBlack")))
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .offset(y: -10)
                    
                    
                    
                    HStack  {
                        
                        VStack(alignment: .leading) {
                            Text("Type: \(selectedLocation?.type ?? "-")")
                            Text("Sqm: \(selectedLocation?.sqm ?? 0)")
                        }
                        .font(.system(size: 15, weight: .regular))
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Rooms: \(selectedLocation?.rooms ?? 0)")
                            Text("Members: \(selectedLocation?.members ?? 1)")
                        }
                        .font(.system(size: 15, weight: .regular))
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Button(action: {
                                // Edit home sheet here
                            }) {
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .light))
                                    .frame(width: 40, height: 40)
                                    .background(Color("BtnBlack"))
                                    .cornerRadius(15)
                            }
                            
                        }
                        
                        
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 110)
                .padding(.horizontal, 20)
                .background(Color.white)
                .cornerRadius(10)
                
                
                
            }
            .frame(maxWidth: .infinity)
            .offset(y: -40)
            
            
            VStack {
                
                HStack {
                    
                    Text("Pending tasks")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        selectedTab = 2
                    }) {
                        Text("View all")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .light))
                            .frame(width: 80, height: 24)
                            .background(Color("BtnBlack"))
                            .cornerRadius(8)
                    }
                }
                .padding(.top, 15)
                
                // Pending taskss
                let pendingTasks = tasksVM.tasks.filter { $0.isCompleted == false && $0.dueDate < Date() }
                
                if pendingTasks.isEmpty {
                    Text("No pending tasks!")
                        .foregroundColor(.gray)
                        .padding(.top, 15)
                }
                else {
                    ScrollView {
                        ForEach(pendingTasks) { task in
                            HStack {
                                Button(action: {
                                    var updatedTask = task
                                    updatedTask.isCompleted.toggle()
                                    if let userID = authVM.user?.uid {
                                        tasksVM.updateTask(updatedTask, from: userID, locationID: locationID)
                                    }
                                }) {
                                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(task.isCompleted ? .green : .gray)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(task.title)
                                        .font(.system(size: 14, weight: .medium))
                                    
                                    Text(task.dueDate, style: .date)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .light))
                                }
                                Spacer()
                            }
                            .padding(.vertical, 6)
                            Divider()
                        }
                    }
                    .frame(maxHeight: 200)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 230)
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(10)
            .offset(y: -30)
            
            
            HStack {
                
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        
                        
                        Text("All tasks")
                            .font(.system(size: 14, weight: .semibold))
                            
                        
                        Spacer()
                        
                        Button(action: {
                            selectedTab = 2
                        }) {
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .light))
                                .frame(width: 30, height: 30)
                                .background(Color("BtnBlack"))
                                .cornerRadius(8)
                        }
                        
                    }
                    
                    Spacer()
                    
                    Text("\(tasksVM.tasks.count)")
                        .font(.system(size: 40, weight: .regular))
                    
                    Spacer()
                    
                }
                .frame(maxWidth: 132, maxHeight: 152)
                .padding(.horizontal, 20)
                .background(Color.white)
                .cornerRadius(10)
                
                Spacer()
                
                VStack {
                    
                    HStack {
                        
                        Text("Leaderboard")
                            .font(.system(size: 14, weight: .semibold))
                        
                        Spacer()
                        
                        Button(action: {
                            // To leaderboard Sheet
                        }) {
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .light))
                                .frame(width: 30, height: 30)
                                .background(Color("BtnBlack"))
                                .cornerRadius(8)
                        }
                        
                    }
                    
                    
                    
                }
                .frame(maxWidth: 132, maxHeight: 152)
                .padding(.horizontal, 20)
                .background(Color.white)
                .cornerRadius(10)
                
            }
            .offset(y: -20)
            
            
            Spacer()
            
        }
        .padding(.horizontal, 20)
        .backgroundGradient()
        .onAppear {
            let uid = authVM.user?.uid ?? ""
            let locationID = selectedLocationManager.locationID
            // Do NOT try to fetch if missing either value
            guard !uid.isEmpty, !locationID.isEmpty else {
                print("Debug: Skipping fetchTasks: missing user id or locationID onAppear")
                return
            }
            locationsVM.fetchLocations(for: uid) { _ in
                print("HomeView: Locations fetched via onappear")
            }
            tasksVM.fetchTasks(for: uid, locationID: locationID)
            print("HomeView LocationsViewModel UUID: \(locationsVM.uuid)")
        }
        .onChange(of: selectedLocationManager.locationID) { oldID, newID in
            let uid = authVM.user?.uid ?? ""
            guard !uid.isEmpty, !newID.isEmpty else {
                print("Debug: Skipping fetchTasks: missing user id or location id onChange")
                return
            }
            print("LocationID changed from \(oldID) to \(newID)")
            tasksVM.fetchTasks(for: uid, locationID: newID)
        }
        
    }
}

#Preview {
    HomeView(selectedTab: .constant(0))
}
