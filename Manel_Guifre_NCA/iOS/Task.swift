import Foundation

// Task
struct Task {
    var id = UUID() // Unique ID
    var content: String // Task content
    var priority = Priority.default // Priority
    var done = false // Done or not
    var date = Date() // Date of creation
}
