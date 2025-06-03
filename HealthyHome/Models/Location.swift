//
//  Location.swift
//  HealthyHome
//
//  Created by Fred on 30/05/2025.
//

import Foundation


struct Location: Identifiable, Codable {
    var id: String = UUID().uuidString
    var address: String
    var sqm: Int
    var rooms: Int
    var type: String
    var members: Int
}
