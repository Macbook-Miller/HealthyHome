import SwiftUI

struct LocationsView: View {
    
    @State private var showCreateLocation = false
    @State private var showFirstLocationSheet = false
    @StateObject private var locationsVM = LocationsViewModel()
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var selectedLocationManager: SelectedLocationManager
    @EnvironmentObject var tasksVM: TasksViewModel
    @Binding var selectedTab: Int
    
    var body: some View {
        
        VStack {
            Text("Select location")
                .font(.largeTitle)
                .foregroundColor(Color("BtnBlack"))
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            List {
                ForEach(locationsVM.locations) { location in
                    locationCell(for: location)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            
            Button(action: {
                showCreateLocation = true
            }) {
                Text("New Location")
                    .foregroundColor(Color("BoxColor"))
                    .padding()
                    .frame(maxWidth: 220)
                    .background(Color("BtnBlack"))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 20)
        }
        .backgroundGradient()
        .sheet(isPresented: $showCreateLocation) {
            CreateLocationSheet()
                .environmentObject(authVM)
        }
        .onAppear {
            if let uid = authVM.user?.uid {
                locationsVM.fetchLocations(for: uid) { _ in
                    for location in locationsVM.locations {
                        locationsVM.fetchTaskCount(for: uid, locationID: location.id)
                    }
                }
            }
        }
        .onChange(of: showCreateLocation) { newValue in
            if newValue == false, let uid = authVM.user?.uid {
                locationsVM.fetchLocations(for: uid) { _ in }
            }
        }
        .onChange(of: locationsVM.locations.count) {
            showFirstLocationSheet = (locationsVM.locations.count == 0)
        }
        .sheet(isPresented: $showFirstLocationSheet) {
            FirstLocationSheet(locationsVM: locationsVM)
                .environmentObject(authVM)
        }
    }
    
    @ViewBuilder
    private func locationCell(for location: Location) -> some View {
        let locationTasks = tasksVM.tasks.filter { $0.locationID == location.id}
        let healthPercent = locationTasks.healthPercentage
        let healthFraction = locationTasks.healthFraction
        let isSelected = selectedLocationManager.locationID == location.id

        VStack(alignment: .leading, spacing: 0) {
            // Top Row: Type, Title (left), Illustration (right)
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(location.type)
                        .font(.caption)
                        .foregroundColor(Color("BtnBlack"))
                        .opacity(0.3)
                        .padding(.leading, 4)
                    Text(location.address)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color("BtnBlack"))
                        .padding(.leading, 4)
                }
                Spacer()
                // Illustration (icon placeholder)
                Image(systemName: "house.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 72, height: 54)
                    .foregroundColor(.gray.opacity(0.13))
                    .offset(y: 8)
                    .padding(.trailing, 12)
            }
            // Card below
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("BoxColor"))
                    .shadow(color: .black.opacity(0.09), radius: 8, x: 0, y: 3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(isSelected ? Color.blue : .clear, lineWidth: 2)
                    )
                VStack(spacing: 8) {
                    HStack(alignment: .center) {
                        ProgressView(value: healthFraction)
                            .progressViewStyle(LinearProgressViewStyle(tint: Color("BtnBlack")))
                            .frame(height: 6)
                            .cornerRadius(3)
                        Spacer()
                        Text("\(healthPercent)%")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("BtnBlack"))
                    }
                    HStack {
                        Text("Type: \(location.type)")
                        Spacer()
                        Text("Rooms: \(location.rooms)")
                    }
                    .font(.caption)
                    .foregroundColor(Color("BtnBlack"))
                    HStack {
                        Text("Tasks: \(locationsVM.taskCounts[location.id] ?? 0)")
                        Spacer()
                        Text("Members: \(location.members)")
                    }
                    .font(.caption)
                    .foregroundColor(Color("BtnBlack"))
                }
                .padding()
            }
            .frame(height: 100)
            .padding(.top, 4)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .onTapGesture {
            selectedLocationManager.locationID = location.id
            print("Selected location ID: \(location.id)")
            selectedTab = 0
        }
        .animation(.easeInOut, value: isSelected)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .swipeActions {
            Button(role: .destructive) {
                if let uid = authVM.user?.uid {
                    withAnimation {
                        locationsVM.deleteLocation(location, for: uid)
                    }
                }
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

#Preview {
    LocationsView(selectedTab: .constant(1))
        .environmentObject(AuthViewModel())
        .environmentObject(SelectedLocationManager())
}
