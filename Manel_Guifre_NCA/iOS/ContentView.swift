import SwiftUI

// ContentView
struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel // ViewModel
    @State private var selectedTab = 1 // Selected tab (default = 1)

    var body: some View {
        TabView(selection: $selectedTab) {
            NotesView().environmentObject(viewModel)
                .tabItem {
                    Image(systemName: "note")
                    Text("Notes")
                }.tag(0)
            TasksView().environmentObject(viewModel) // Default
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Tasks")
                }.tag(1)
            StopwatchView(stopwatch: viewModel.stopwatchModel)
                .tabItem {
                    Image(systemName: "stopwatch")
                    Text("Stopwatch")
                }.tag(2)
        }
    }
}
