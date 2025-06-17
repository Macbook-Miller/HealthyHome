//
//  Task.swift
//  HealthyHome
//
//  Created by Fred on 30/05/2025.
//

import Foundation
import FirebaseFirestore

struct Task: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var dueDate: Date
    var isCompleted: Bool
    var locationID: String
    
    init(id: String? = nil, title: String, dueDate: Date, isCompleted: Bool = false, locationID: String) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.locationID = locationID
    }
}
