import Foundation
import SwiftUI

// TasksModel
struct TasksModel {
    var tasks: [Task] = [ // This is the default data
        Task(content: "Write a report", priority: .high, done: false, date: Date()),
        Task(content: "Prepare a presentation", priority: .medium, done: true, date: Date()),
        Task(content: "Attend a meeting", priority: .low, done: false, date: Date()),
        Task(content: "Buy groceries", priority: .default, done: true, date: Date()),
        Task(content: "Pay bills", priority: .high, done: false, date: Date()),
        Task(content: "Call mom", priority: .medium, done: false, date: Date()),
        Task(content: "Watch a movie", priority: .low, done: true, date: Date()),
        Task(content: "Go to the party", priority: .default, done: false, date: Date()),
    ]

    // Add task
    mutating func addTask(task: Task) {
        tasks.append(task)
    }

    // Delete task
    mutating func deleteTask(id: UUID) {
        for (index, task) in tasks.enumerated() {
            if task.id == id {
                tasks.remove(at: index)
                break
            }
        }
    }

    // Task done
    mutating func taskDone(id: UUID) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].done = true
        }
    }

    // Task undone
    mutating func taskUnDone(id: UUID) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].done = false
        }
    }

    // Order tasks by priority
    mutating func orderTasksByPriority() {
        tasks.sort(by: { $0.priority.rawValue > $1.priority.rawValue })
    }

    // Order tasks by date
    mutating func orderTasksByDate() {
        tasks.sort(by: { $0.date < $1.date })
    }
}
