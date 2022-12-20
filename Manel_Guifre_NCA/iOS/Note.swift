import SwiftUI

// Note
struct Note: Identifiable {
    var id = UUID() // Unique ID
    var title = "" // Title
    var content = "" // Content
    var date = Date() // Date created
    var color = NoteColor.blue // Color
}
