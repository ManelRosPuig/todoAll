import SwiftUI

// NotesModel
struct NotesModel {
    var notes = [ // Array of notes
        Note(title: "SHOPPING LIST", content: "Shopping list for the week\n- Milk\n- Bread\n - Eggs\n- Cheese\n- Butter\n- Chicken\n- Beef\n- Pork\n- Fish\n- Vegetables\n- Fruits\n- Cereals\n- Pasta\n- Rice", color: .green),
        Note(title: "REMINDER", content: "Reminders for the week\n1. Call mom\n2. Call dad\n3. Call sister\n4. Study PHP\n5. Study Kotlin\n6. Finish NCA", color: .yellow),
        Note(title: "PASSWORDS", content: "Passwords\n1. Facebook: neliitoOwnsYou\n2. Instagram: iHateiOS\n3. Twitter: phpEz\n4. Gmail: sistemesEasyWin\n5. Yahoo: whoUsesThis\n6. Outlook: iLoveAndroid", color: .red),
        Note(title: "SERIES TO WATCH", content: "Series to watch\n1. The Big Bang Theory\n2. The Flash\n3. Arrow\n4. The Walking Dead\n5. The 100\n6. Lucifer\n7. The Good Doctor\n8.The Good Place\n9.The Mandalorian\n10.The Witcher", color: .blue)
    ]

    // Function to add a note
    mutating func addNote(note: Note) {
        notes.append(note)
    }

    // Function to remove a note
    mutating func deleteNote(id: UUID) {
        notes.removeAll { $0.id == id }
    }

    // Function to update a note
    mutating func updateNote(note: Note) {
        for i in 0..<notes.count {
            if notes[i].id == note.id {
                notes[i] = note
            }
        }
    }

    // Function to update the notes array
    mutating func updateNotes() {
        for i in 0..<notes.count {
            notes[i].date = Date()
        }
    }
}