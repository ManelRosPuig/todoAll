import SwiftUI

extension View {
    func titleStyle() -> some View { modifier(TitleStyle()) }
    func basicButtonStyle() -> some View { modifier(BasicButtonStyle()) }
    func noteActionButtonStyle(color: NoteColor) -> some View { modifier(NoteActionButtonStyle(color: color)) }
    func stopWatchStylePortrait() -> some View { modifier(StopWatchStylePortrait()) }
    func stopWatchStyleLandscape() -> some View { modifier(StopWatchStyleLandscape()) }
    func taskStyle(priority: Priority) -> some View { modifier(TaskStyle(taskPriority: priority)) }
    func textFieldTaskStyle(firstTime: Bool, priority: Priority) -> some View { modifier(TextFieldTaskStyle(firstTime: firstTime, taskPriority: priority)) }
    func flagButtonStyle() -> some View { modifier(FlagButtonStyle()) }
    func trashButtonStyle() -> some View { modifier(TrashButtonStyle()) }
    func noteButtonStyle(color: NoteColor) -> some View { modifier(NoteButtonStyle(color: color)) }
    func titleTextFieldStyle() -> some View { modifier(TitleTextFieldStyle()) }
    func checkboxStyle(color: NoteColor) -> some View { modifier(CheckboxStyle(color: color)) }
    func textCheckboxStyle(color: NoteColor) -> some View { modifier(TextCheckboxStyle(color: color)) }
    func textEditorStyle() -> some View { modifier(TextEditorStyle()) }
}

// View extension to change the placeholder color
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

// TitleStyle
struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 58, weight: .bold))
            .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 0)
    }
}

// BasicButtonStyle
struct BasicButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .shadow(radius: 10)
    }
}

// BasicButtonStyle
struct NoteActionButtonStyle: ViewModifier {
    var color: NoteColor
    var noteColor: Color {
        switch color {
        case .blue:
            return Color.blue
        case .green:
            return Color.green
        case .yellow:
            return Color.yellow
        case .red:
            return Color.red
        }
    }
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.white)
            .padding()
            .background(noteColor)
            .shadow(radius: 10)
    }
}

// Stopwatch style for portrait mode
struct StopWatchStylePortrait: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 100, weight: .bold))
            .padding()
            .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 0)
    }
}

// Stopwatch style for landscape mode
struct StopWatchStyleLandscape: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 130, weight: .bold))
            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 0)
    }
}

// Text of the task
struct TaskStyle: ViewModifier {
    var taskPriority: Priority
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .foregroundColor(
                taskPriority == Priority.low ||
                taskPriority == Priority.medium ? Color.black : .white
            )
            .background(
                taskPriority == Priority.default ? Color.blue :
                taskPriority == Priority.low ? Color.green :
                taskPriority == Priority.medium ? Color.yellow :
                taskPriority == Priority.high ? Color.red : Color.blue
            )
            .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 0)
    }
}

// TexFieldTaskStyle
struct TextFieldTaskStyle: ViewModifier {
    var firstTime: Bool
    var taskPriority: Priority
    func body(content: Content) -> some View {
        content
            .frame(height: 65, alignment: .leading)
            .cornerRadius(12)
            .foregroundColor(firstTime ||
                taskPriority == Priority.low ||
                taskPriority == Priority.medium ? Color.black : .white
            )
            .background(
                taskPriority == Priority.default && !firstTime ? Color.blue :
                taskPriority == Priority.low && !firstTime ? Color.green :
                taskPriority == Priority.medium && !firstTime ? Color.yellow :
                taskPriority == Priority.high && !firstTime ? Color.red : Color.white
            )
            .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 0)
    }
}

// FlagButtonStyle
struct FlagButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .clipShape(Circle())
            .shadow(radius: 10)
    }
}

// TrashButtonStyle
struct TrashButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(Color.white)
            .background(Rectangle().fill(Color.black))
            .cornerRadius(10)
    }
}

// NoteButtonStyle
struct NoteButtonStyle: ViewModifier {
    var color: NoteColor
    var noteColor: Color {
        switch color {
        case .blue:
            return Color.blue
        case .green:
            return Color.green
        case .yellow:
            return Color.yellow
        case .red:
            return Color.red
        }
    }
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(noteColor == .blue || noteColor == .red ? Color.white : Color.black)
            .padding()
            .frame(width: 170, height: 170)
            .background(Rectangle().fill(noteColor))
            .cornerRadius(20)
            .shadow(radius: 10)
    }
}

// TitleTextFieldStyle
struct TitleTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
    }
}

// CheckboxStyle
struct CheckboxStyle: ViewModifier {
    var color: NoteColor
    var checkboxColor: Color {
        switch color {
        case .blue:
            return Color.blue
        case .green:
            return Color.green
        case .yellow:
            return Color.yellow
        case .red:
            return Color.red
        }
    }
    func body(content: Content) -> some View {
        content
            .frame(width: 20, height: 20)
            .foregroundColor(checkboxColor)
    }
}

// TextCheckboxStyle
struct TextCheckboxStyle: ViewModifier {
    var color: NoteColor
    var checkboxColor: Color {
        switch color {
        case .blue:
            return Color.blue
        case .green:
            return Color.green
        case .yellow:
            return Color.yellow
        case .red:
            return Color.red
        }
    }
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25))
            .shadow(radius: 10)
            .foregroundColor(checkboxColor)
    }
}

// TextEditorStyle
struct TextEditorStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.2))
    }
}
