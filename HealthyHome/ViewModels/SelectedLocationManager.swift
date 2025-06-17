//
//  SelectedLocationManager.swift
//  HealthyHome
//
//  Created by Fred on 11/06/2025.
//

import Foundation


class SelectedLocationManager: ObservableObject {
    @Published var locationID: String = "" {
        didSet {
            UserDefaults.standard.set(locationID, forKey: "lasSelectedLocationID")
        }
    }
    
    init() {
        self.locationID = UserDefaults.standard.string(forKey: "lastSelectedLocationID") ?? ""
    }
}
