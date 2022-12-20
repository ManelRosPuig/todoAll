import Foundation
import UIKit

class ViewModel: ObservableObject {
    // Notes variables ----------------------------------------------------
    @Published var notesModel = NotesModel() // NotesModel
    var notes: [Note] {
        notesModel.notes
    }

    // Tasks variables ----------------------------------------------------
    @Published var tasksModel = TasksModel() // TaskModel
    var tasks: [Task] {
        tasksModel.tasks
    }

    // Stopwatch variables ------------------------------------------------
    @Published var stopwatchModel = StopwatchModel() // StopwatchModel
    var display: String {
        stopwatchModel.display
    }
    var isRunning: Bool {
        stopwatchModel.isRunning
    }

    // Notes functions ----------------------------------------------------
    func addNote(note: Note) {
        notesModel.addNote(note: note)
    }

    func updateNote(note: Note) {
        notesModel.updateNote(note: note)
    }

    func deleteNote(id: UUID) {
        notesModel.deleteNote(id: id)
    }

    func updateNotes() {
        notesModel.updateNotes()
    }

    // Tasks functions ----------------------------------------------------
    func taskDone(id: UUID) {
        tasksModel.taskDone(id: id)
    }

    func taskUnDone(id: UUID) {
        tasksModel.taskUnDone(id: id)
    }

    func deleteTask(id: UUID) {
        tasksModel.deleteTask(id: id)
    }

    func addTask(task: Task) {
        tasksModel.addTask(task: task)
    }

    func orderTaskByPriority() {
        tasksModel.orderTasksByPriority()
    }

    func orderTaskByDate() {
        tasksModel.orderTasksByDate()
    }

    // Stopwatch functions ------------------------------------------------
    func startPause() {
        stopwatchModel.startPause()
    }

    func clear() {
        stopwatchModel.clear()
    }
}
