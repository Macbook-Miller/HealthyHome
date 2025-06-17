//
//  TaskModel+Health.swift
//  HealthyHome
//
//  Created by Fred on 17/06/2025.
//

import Foundation


extension Array where Element == Task {
    // nr of pending/overdue tasks
    var pendingTaskCount: Int {
        self.filter { !$0.isCompleted && $0.dueDate < Date() }.count
    }
    // health as a o..1 fraction for progessbar/healthbar
    var healthFraction: Double {
        let total = self.count
        guard total > 0 else { return 1.0 }
        return Double(total - pendingTaskCount) / Double(total)
    }
    // health as percentage 0...100 for the text
    var healthPercentage: Int {
        Int((self.healthFraction * 100).rounded())
    }
}
