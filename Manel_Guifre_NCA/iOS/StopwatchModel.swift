import Foundation

// StopwatchModel
class StopwatchModel: ObservableObject {
    @Published var elapsedTime = 0.0 // Elapsed time in seconds
    var timer = Timer() // Timer
    @Published var isRunning = false // Is the stopwatch running?
    var display: String { // Display time in mm:ss format
        let formatter = DateComponentsFormatter() // Date components formatter
        formatter.unitsStyle = .positional // Use mm:ss format
        formatter.allowedUnits = [.minute, .second] // mm:ss
        formatter.zeroFormattingBehavior = .pad // Pad with zeros
        return formatter.string(from: elapsedTime) ?? "00:00" // Return formatted time
    }

    // Start or pause the stopwatch
    func startPause() {
        if !isRunning { // If not running, start the timer
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
                elapsedTime += 1
            }
        } else { // If running
            timer.invalidate() // Stop the timer
        }
        isRunning.toggle() // Toggle the running state
    }

    // Clear the stopwatch
    func clear() {
        elapsedTime = 0 // Reset the elapsed time
    }
}

/*
class StopwatchModel {
    var elapsedTime = 0.0 // Elapsed time in seconds
    var timer = Timer() // Timer
    var isRunning = false // Is the stopwatch running?
    var display: String { // Display time in mm:ss format
        let formatter = DateComponentsFormatter() // Date components formatter
        formatter.unitsStyle = .positional // Use mm:ss format
        formatter.allowedUnits = [.minute, .second] // mm:ss
        formatter.zeroFormattingBehavior = .pad // Pad with zeros
        return formatter.string(from: elapsedTime) ?? "00:00" // Return formatted time
    }

    // Start or pause the stopwatch
    func startPause() {
        if !isRunning { // If not running, start the timer
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
                elapsedTime += 1
            }
        } else { // If running
            timer.invalidate() // Stop the timer
        }
        isRunning.toggle() // Toggle the running state
    }

    // Clear the stopwatch
    func clear() {
        elapsedTime = 0 // Reset the elapsed time
    }
}
*/
