import SwiftUI

// NoteView
struct NoteView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.verticalSizeClass) var verticalSizeClass // VerticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // HorizontalSizeClass
    private var isPortrait: Bool { horizontalSizeClass == .compact } // Cleaner code
    @Environment(\.presentationMode) var presentationMode // PresentationMode
    @State var title = "" // Title of the note
    @State var content = "Insert your note here..." // Content of the note (it have a placeholder if it's empty)
    @State var viewState: ViewState = .ViewNote // ViewState of the view (ViewNote, EditNote, AddNote)
    @State var color: NoteColor = .blue // Color of the note
    @State var showCancelAlert = false // ShowCancelAlert
    @State var showDiscardChangesAlert = false // ShowDiscardChangesAlert
    @State var showDeleteAlert = false // ShowDeleteAlert
    @State var showTitleAlert = false // ShowTitleAlert
    @State var showContentAlert = false // ShowContentAlert
    var note: Note // Note

    var body: some View {
        VStack {
            if isPortrait { // If the device is in portrait mode
                Text(viewState == .AddNote ? "Add Note" : // If the view state is AddNote show "Add Note"
                        viewState == .ViewNote ? "View Note" // If the view state is ViewNote show "View Note"
                        : "Edit Note").titleStyle().padding(.top, 16) // If the view state is EditNote show "Edit Note"
            }
            // TextField for the title
            TextField("Insert the title here...", text: $title).onChange(of: title) { (newValue) in
                if viewState == .ViewNote { // If the user changes the value, change the view state to EditNote
                    viewState = .EditNote // If the view was in ViewNote, change it to EditNote
                }
            }.navigationBarTitle("").navigationBarHidden(true) // Hide the navigation bar title
            .titleTextFieldStyle()
            if isPortrait { // If the device is in portrait mode
                Text(viewState == .AddNote ? "Choose the color for your note:" : // If is AddNote
                        "Color of the note:").padding(.top, 16) // If is ViewNote or EditNote
            }
            HStack { // HStack for the color buttons
                ForEach(NoteColor.allCases, id: \.self) { color in // For each color in NoteColor
                    Button(action: { // Color button
                        self.color = color // Change the color of the note
                        if viewState == .ViewNote { // If the user changes the value, change the view state to EditNote
                            viewState = .EditNote // If the view was in ViewNote, change it to EditNote
                        }
                    }) {
                        Image(systemName: // To simulate a checkbox we can switch between two SF Symbols
                        self.color == color // If the color of the note is the same as the color of the button
                                ? "checkmark.circle.fill" : "circle") // Show the checkmark
                                .resizable().checkboxStyle(color: color) // Checkbox style
                        Text(color == NoteColor.blue ? "Blue" : // If the color is blue show "Blue"
                            color == NoteColor.green ? "Green" : // If the color is green show "Green"
                            color == NoteColor.yellow ? "Yellow" : // If the color is yellow show "Yellow"
                                "Red").textCheckboxStyle(color: color) // If the color is red show "Red"
                    }
                } // We can't put two alerts in the same view so we need put it in another view, for instance, a HStack
            }.alert(isPresented: $showDeleteAlert, content: { // Alert for the delete button
                Alert(title: Text("Are you sure you want to delete this note?"),
                        primaryButton: .destructive(Text("Delete")) { // Delete button
                    viewModel.deleteNote(id: note.id) // Delete the note
                    presentationMode.wrappedValue.dismiss() // Dismiss the view
                }, secondaryButton: .cancel()) // Cancel button
            })
            TextEditor(text: $content) // TextEditor for the content (multiline text field)
                .onChange(of: content, perform: { value in // If the user changes the value
                    if viewState == .ViewNote { // If the view state was ViewNote
                        viewState = .EditNote // Change the value of the view state to EditNote
                    }
                }).foregroundColor(content == "Insert your note here..." // If the content is empty
                            ? Color.gray // The foreground color is gray
                            : Color.black) // Else, the foreground color is black
                .onTapGesture { // If the user tap the text editor
                    if content == "Insert your note here..." { // If the content is empty
                        content = "" // Set the content to empty
                    }
                }
                .textEditorStyle() // TextEditor style
                .alert(isPresented: $showContentAlert, content: { // Alert if the content is empty
                    Alert(title: Text("Content is empty"), message: Text("Please insert some content for your note"),
                            dismissButton: .default(Text("Ok"))) // Ok button
                })
            Spacer().alert(isPresented: $showDiscardChangesAlert, content: { // Alert if the user discard the changes
                Alert(title: Text("Discard changes?"), message: Text("Are you sure you want to discard the changes?"),
                        primaryButton: .destructive(Text("Discard"), action: { // Discard button
                    presentationMode.wrappedValue.dismiss() // Dismiss the view
                }), secondaryButton: .cancel()) // Cancel button
            })
            HStack {
                Button(action: { // Left button
                    if viewState == .AddNote { // If the view state is AddNote
                        // If the title and the content are empty
                        if title == "" && content == "Insert your note here..." || content == "" {
                            presentationMode.wrappedValue.dismiss() // Dismiss the view
                        } else { // If the title or the content are not empty
                            showCancelAlert = true // Show the cancel alert
                        }
                    } else if viewState == .EditNote { // If the view state is EditNote
                        showDiscardChangesAlert = true // Show the discard changes alert
                    } else { // If the view state is ViewNote
                        presentationMode.wrappedValue.dismiss() // Dismiss the view
                    }
                }) { // Left button text
                    Text(viewState == .AddNote ? "Cancel" // If the view state is AddNote show "Cancel"
                            : viewState == .ViewNote ? "Back" // If the view state is ViewNote show "Back"
                            : "Discard\nChanges" // If the view state is EditNote show "Discard Changes"
                    ).frame(maxWidth: .infinity) // Set the max width to infinity
                }.noteActionButtonStyle(color: color) // Left button style
                .alert(isPresented: $showCancelAlert, content: { // Alert if the user cancel the note
                    Alert(title: Text("Cancel?"), message: Text("Are you sure you want to cancel?"),
                            primaryButton: .destructive(Text("Yes, I'm sure"), action: {
                        presentationMode.wrappedValue.dismiss() // Dismiss the view
                    }), secondaryButton: .cancel()) // Cancel button
                })
                Button(action: { // Right button
                    if viewState == .AddNote { // If the view state is AddNote
                        if title == "" { // If the title is empty
                            showTitleAlert = true // Show the title alert
                        } else if content == "" || content == "Insert your note here..." { // If the content is empty
                            showContentAlert = true // Show the content alert
                        } else { // If the title and the content are not empty
                            viewModel.addNote(note: Note(title: title, content: content, color: color)) // Add the note
                            presentationMode.wrappedValue.dismiss() // Dismiss the view
                            viewModel.updateNotes() // Update the notes
                        }
                    } else if viewState == .EditNote { // If the view state is EditNote
                        if title == "" { // If the title is empty
                            showTitleAlert = true // Show the title alert
                        } else if content == "" || content == "Insert your note here..." { // If the content is empty
                            showContentAlert = true // Show the content alert
                        } else { // If the title and the content are not empty
                            // Update the note
                            viewModel.updateNote(note: Note(id: note.id, title: title, content: content, color: color))
                            presentationMode.wrappedValue.dismiss() // Dismiss the view
                            viewModel.updateNotes() // Update the notes
                        }
                    } else { // If the view state is ViewNote
                        showDeleteAlert = true // Show the delete alert
                    }
                }) { // Right button text
                    Text(viewState == .AddNote ? "Add Note" // If the view state is AddNote show "Add Note"
                            : viewState == .ViewNote ? "Delete Note" // If the view state is ViewNote show "Delete Note"
                            : "Save\nChanges" // If the view state is EditNote show "Save Changes"
                    ).frame(maxWidth: .infinity) // Set the max width to infinity
                }.noteActionButtonStyle(color: color) // Right button style
                .alert(isPresented: $showTitleAlert, content: { // Alert if the title is empty
                    Alert(title: Text("Title is empty"), message: Text("Please insert a title for your note"),
                            dismissButton: .default(Text("Ok"))) // Ok button
                })
            }
        }.padding()
    }
}
