import SwiftUI


// NotesView
struct NotesView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.verticalSizeClass) var verticalSizeClass // VerticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // HorizontalSizeClass
    private var isPortrait: Bool { horizontalSizeClass == .compact } // Cleaner code
    @State private var showViewNoteView = false // Show view of NoteView but with view state
    @State private var showAddNoteView = false // Show view of NoteView but with add state
    @State var noteBinding = Note()
    var body: some View {
        VStack {
            if isPortrait { // Portrait
                Text("Notes").titleStyle()
            }
            ScrollView { // ScrollView
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) { // LazyVGrid
                    ForEach(viewModel.notes) { note in // ForEach for notes in viewModel
                        ZStack(alignment: .topTrailing) { // ZStack to display correctly the trash button
                            Button(note.title) {
                                noteBinding = note
                                showViewNoteView = true
                            }.noteButtonStyle(color: note.color)
                            Button(action: { viewModel.deleteNote(id: note.id) }) { // Trash button
                                Image(systemName: "trash").trashButtonStyle() // TrashButtonStyle
                            }
                        }
                    }
                }.padding()
            }.sheet(isPresented: $showAddNoteView) {
                NoteView(viewState: .AddNote, note: noteBinding).environmentObject(viewModel)
            }
            Button(action: {
                showAddNoteView = true // Show NoteView with add state
            }) {
                Text("Add Note").frame(maxWidth: .infinity) // Width all across the screen
            }.basicButtonStyle().sheet(isPresented: $showViewNoteView) {
                NoteView(title: noteBinding.title, content: noteBinding.content, color: noteBinding.color, note: noteBinding).environmentObject(viewModel)
            } // Button style
        }.padding()
    }
}
