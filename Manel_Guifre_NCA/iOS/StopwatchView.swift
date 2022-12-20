import SwiftUI

// StopwatchView
struct StopwatchView: View {
    @ObservedObject var stopwatch: StopwatchModel // StopwatchModel
    @Environment(\.verticalSizeClass) var verticalSizeClass // VerticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // HorizontalSizeClass
    private var isPortrait: Bool { horizontalSizeClass == .compact } // Cleaner code

    var body: some View {
        VStack { // Create a VStack
            if isPortrait { // If the device is in portrait mode
                Text("Stopwatch").titleStyle().padding() // Title
                Spacer() // Spacer
                Text(stopwatch.display).stopWatchStylePortrait() // With the portrait style
            } else { // If the device is in landscape mode
                Spacer() // Spacer
                Text(stopwatch.display).stopWatchStyleLandscape()
            }
            Spacer() // Add a Spacer
            HStack(spacing: 16) {
                // Add a Button view that starts the stopwatch when tapped
                Button(action: stopwatch.startPause) {
                    Text(stopwatch.isRunning ? "Pause" : "Start").frame(maxWidth: .infinity)
                }.basicButtonStyle()
                // Add a Button view that clears the stopwatch when tapped
                Button(action: stopwatch.clear) { // All the way across the screen
                    Text("Clear").frame(maxWidth: .infinity)
                }.basicButtonStyle() // Use the basicButtonStyle
            }.padding()
        }
    }
}

/*
struct StopwatchView: View {
    @EnvironmentObject var viewModel: ViewModel // StopwatchModel
    @Environment(\.verticalSizeClass) var verticalSizeClass // VerticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // HorizontalSizeClass
    private var isPortrait: Bool { horizontalSizeClass == .compact } // Cleaner code

    var body: some View {
        VStack { // Create a VStack
            if isPortrait { // If the device is in portrait mode
                Text("Stopwatch").titleStyle().padding() // Title
                Spacer() // Spacer
                Text(viewModel.display).stopWatchStylePortrait() // With the portrait style
            } else { // If the device is in landscape mode
                Spacer() // Spacer
                Text(viewModel.display).stopWatchStyleLandscape()
            }
            Spacer() // Add a Spacer
            HStack(spacing: 16) {
                // Add a Button view that starts the stopwatch when tapped
                Button(action: viewModel.startPause) {
                    Text(viewModel.isRunning ? "Pause" : "Start").frame(maxWidth: .infinity)
                }.basicButtonStyle()
                // Add a Button view that clears the stopwatch when tapped
                Button(action: viewModel.clear) { // All the way across the screen
                    Text("Clear").frame(maxWidth: .infinity)
                }.basicButtonStyle() // Use the basicButtonStyle
            }.padding()
        }
    }
}
*/
