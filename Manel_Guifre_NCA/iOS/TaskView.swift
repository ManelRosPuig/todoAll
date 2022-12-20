import SwiftUI

// TasksView
struct TasksView: View {
    @EnvironmentObject var viewModel: ViewModel // ViewModel
    @Environment(\.verticalSizeClass) var verticalSizeClass // VerticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // HorizontalSizeClass
    private var isPortrait: Bool { horizontalSizeClass == .compact } // Cleaner code
    @State var textContent = "" // Content of the TextField
    @State var textButton = "Order By Priority" // Text of the "ORDER BY" button
    @State var showAlert = false // Show the alert of "Error" or not
    @State var choosePriority = false // Show the alert of "Choose Priority" or not
    @State var priority = Priority.default // Priority of the task
    @State var firstTime = true // Is it the first time the user opens the app?

    var body: some View {
        VStack { // Create a VStack
            if isPortrait { // If the device is in portrait mode
                Text("Tasks").titleStyle() // Display the title
                Spacer() // Add a Spacer
            }
            List { // Create a List of the tasks
                ForEach(viewModel.tasks, id: \.id) { task in
                    HStack { // Create a HStack
                        Button(action: { // Add a Button view that marks the task as done when tapped
                            if task.done { // If the task is done
                                viewModel.taskUnDone(id: task.id) // Mark the task as undone
                            } else { // If the task is not done
                                viewModel.taskDone(id: task.id) // Mark the task as done
                            }
                        }) {
                            Image(systemName: task.done ? "checkmark.circle.fill" : "circle")
                                .resizable().frame(width: 20, height: 20)
                        }.buttonStyle(BorderlessButtonStyle()).padding(.trailing, 10)
                        Text(task.content) // Display the content of the task
                            .strikethrough(task.done) // If the task is done, strike through the text
                            .taskStyle(priority: task.priority) // With the task style
                        Spacer() // Add a Spacer
                        Button(action: { // Add a Button view that deletes the task when tapped
                            viewModel.deleteTask(id: task.id) // Delete the task
                        }) {
                            Image(systemName: "trash").resizable().frame(width: 20, height: 20)
                        }.padding().buttonStyle(BorderlessButtonStyle())
                    }.listRowInsets(EdgeInsets()) // Remove the default padding
                }
            }

            if isPortrait {
                Button(action: { // Add a Button view that order the tasks by priority/date when tapped
                    if textButton == "Order By Priority" { // If the button says "ORDER BY PRIORITY"
                        viewModel.orderTaskByPriority() // Order the tasks by priority
                        textButton = "Order By Date" // Change the text of the button
                    } else { // If the button says "ORDER BY DATE"
                        viewModel.orderTaskByDate() // Order the tasks by date
                        textButton = "Order By Priority" // Change the text of the button
                    }
                }) {
                    Text(textButton).frame(maxWidth: .infinity)
                }.basicButtonStyle()
            }

            HStack { // Create a HStack
                TextField("", text: $textContent) // TextField to add a task
                        .placeholder(when: textContent.isEmpty) {
                            Text("Insert your task here...")
                                    .foregroundColor(firstTime ||
                                        priority == Priority.low ||
                                        priority == Priority.medium ? .black : .white)
                        }.textFieldTaskStyle(firstTime: firstTime, priority: priority)
                    Button { // Add a Button that shows the alert of "Choose Priority" when tapped
                        choosePriority = true // Show the alert of "Choose Priority"
                    } label: {
                        Image(systemName: "flag") // Flag icon
                    }.flagButtonStyle() // With the flag button style
                    .actionSheet(isPresented: $choosePriority) {
                        ActionSheet(title: Text("Choose priority"), message: Text("Choose one of this :"), buttons: [
                            .default(Text("Default - 0")) {
                                priority = Priority.default // Set the priority to default
                                firstTime = false // It's not the first time the user opens the app
                            },
                            .default(Text("Low - 1")) {
                                priority = Priority.low // Set the priority to low
                                firstTime = false // It's not the first time the user opens the app
                            },
                            .default(Text("Medium - 2")) {
                                priority = Priority.medium // Set the priority to medium
                                firstTime = false // It's not the first time the user opens the app
                            },
                            .default(Text("High - 3")) {
                                priority = Priority.high // Set the priority to high
                                firstTime = false // It's not the first time the user opens the app
                            },
                            .cancel()
                        ])
                    }
                    /*
                    .alert("Choose priority", isPresented: $choosePriority) { // Alert
                        Button("Default - 0", action: { // Default priority
                            priority = Priority.default // Set the priority to default
                            firstTime = false // It's not the first time the user opens the app
                        })
                        Button("Low - 1", action: { // Low priority
                            priority = Priority.low // Set the priority to low
                            firstTime = false // It's not the first time the user opens the app
                        })
                        Button("Medium - 2", action: { // Medium priority
                            priority = Priority.medium // Set the priority to medium
                            firstTime = false // It's not the first time the user opens the app
                        })
                        Button("High - 3", action: { // High priority
                            priority = Priority.high // Set the priority to high
                            firstTime = false // It's not the first time the user opens the app
                        })
                        Button("Cancel", role: .cancel) {} // Cancel button
                    }*/
            }

            if isPortrait {
                Button(action: { // Add a Button view that adds a task when tapped
                    if textContent.isEmpty { // If the TextField is empty
                        showAlert = true // Show the alert of "Error"
                    } else { // If the TextField is not empty
                        viewModel.addTask(task: Task(content: textContent, priority: priority)) // Add the task
                        textContent = "" // Empty the TextField
                        priority = Priority.default // Reset the priority
                    }
                }) {
                    Text("Add task").frame(maxWidth: .infinity) // Full width
                }.basicButtonStyle() // With the basic button style
                .alert(isPresented: $showAlert, content: { // Alert
                    Alert(title: Text("Error"), // Title
                            message: Text("You can't add an empty task"), // Message
                            dismissButton: .default(Text("Ok"))) // Dismiss button
                })
            } else {
                HStack(spacing: 16) {
                    Button(action: { // Add a Button view that order the tasks by priority/date when tapped
                        if textButton == "ORDER BY PRIORITY" { // If the button says "ORDER BY PRIORITY"
                            viewModel.orderTaskByPriority() // Order the tasks by priority
                            textButton = "ORDER BY DATE" // Change the text of the button
                        } else { // If the button says "ORDER BY DATE"
                            viewModel.orderTaskByDate() // Order the tasks by date
                            textButton = "ORDER BY PRIORITY" // Change the text of the button
                        }
                    }) {
                        Text(textButton).frame(maxWidth: .infinity)
                    }.basicButtonStyle()
                    Button(action: { // Add a Button view that adds a task when tapped
                        if textContent.isEmpty { // If the TextField is empty
                            showAlert = true // Show the alert of "Error"
                        } else { // If the TextField is not empty
                            viewModel.addTask(task: Task(content: textContent, priority: priority)) // Add the task
                            textContent = "" // Empty the TextField
                            priority = Priority.default // Reset the priority
                            firstTime = true // Reset the first time
                        }
                    }) {
                        Text("Add task").frame(maxWidth: .infinity) // Full width
                    }.basicButtonStyle() // With the basic button style
                    .alert(isPresented: $showAlert, content: { // Alert
                        Alert(title: Text("Error"), // Title
                        message: Text("You can't add an empty task"), // Message
                        dismissButton: .default(Text("Ok"))) // Dismiss button
                    })
                }
            }
            Spacer() // Add a Spacer
        }.padding() // Padding of the VStack to make it look better
    }
}

