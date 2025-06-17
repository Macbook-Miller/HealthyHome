//
//  ImageSelector+Health.swift
//  HealthyHome
//
//  Created by Fred on 17/06/2025.
//

import Foundation
import SwiftUI


struct HouseImageHelper {
    static func imageName(for healthPercent: Int) -> String {
        healthPercent > 50 ? "House" : "unhealthyHouse"
    }
}




