//
//  Task.swift
//  Task
//
//  Created by Ben Erekson on 7/21/21.
//

import Foundation

class Task: Codable {
    var name: String
    var notes: String?
    var dueDate: Date?
    var isCompleted: Bool
    
    init(name: String, notes: String?, dueDate: Date?, isCompleted: Bool = false) {
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
    
}

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.name == rhs.name && lhs.notes == rhs.notes && lhs.dueDate == rhs.dueDate && lhs.isCompleted == rhs.isCompleted
    }
}
