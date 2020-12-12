import SwiftUI

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct ColorfulBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S

    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.NPSButtonStart, Color.NPSButtonEnd))
                    .overlay(shape.stroke(LinearGradient(Color.NPSButtonStart, Color.NPSButtonEnd), lineWidth: 4))
                    .shadow(color: Color.NPSDarkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.NPSDarkEnd, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(Color.NPSDarkStart, Color.NPSDarkEnd))
                    .overlay(shape.stroke(LinearGradient(Color.NPSButtonStart, Color.NPSButtonEnd), lineWidth: 4))
                    .shadow(color: Color.NPSDarkStart, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.NPSDarkEnd, radius: 10, x: 10, y: 10)
            }
        }
    }
}

struct ColorfulButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                ColorfulBackground(isHighlighted: configuration.isPressed, shape: Circle())
            )
            .animation(nil)
    }
}

struct ColorfulSquareButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Rectangle())
            .background(
                ColorfulBackground(isHighlighted: configuration.isPressed, shape: Rectangle())
            )
            .animation(nil)
    }
}

struct ColorfulToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            configuration.label
                .padding(30)
                .contentShape(Circle())
        }
        .background(
            ColorfulBackground(isHighlighted: configuration.isOn, shape: Circle())
        )
    }
}


struct ContentView: View {
    @State private var isToggled = false

    var body: some View {
        ZStack {
            LinearGradient(Color.NPSBackgroundGradientStart, Color.NPSBackgroundGradientEnd)

            VStack(spacing: 40) {
                Button(action: {
                    print("Button tapped")
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.NPSAlternateButtonColorStart)
                }
                .buttonStyle(ColorfulButtonStyle())

                Toggle(isOn: $isToggled) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.NPSAlternateButtonColorStart)
                }
                .toggleStyle(ColorfulToggleStyle())
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().colorScheme(.light)
    }
}

