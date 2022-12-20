import SwiftUI

// Main
@main
struct iOSApp: App {
    @StateObject var viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)
        }
    }
}
