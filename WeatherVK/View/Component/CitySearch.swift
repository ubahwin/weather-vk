import SwiftUI
import MapKit

struct CitySearch<Content: View>: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.weatherReducer) private var weatherReducer: WeatherReducer

    @Binding var isOpen: Bool
    let content: Content

    @GestureState private var translation: CGFloat = 0
    @Binding var keyboardHeight: CGFloat
    let height: CGFloat = 300

    @State private var citySearch = ""

    init(
        isOpen: Binding<Bool>,
        keyboardHeight: Binding<CGFloat>,
        @ViewBuilder content: () -> Content
    ) {
        self._isOpen = isOpen
        self._keyboardHeight = keyboardHeight
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedTopRectangle(radius: 25)
                    .fill(.white)
                content
            }
            .ignoresSafeArea()
            .frame(maxHeight: height)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(translation, 0))
            .gesture(
                DragGesture()
                    .updating($translation) { value, state, _ in
                        withAnimation {
                            state = value.translation.height
                        }
                    }
                    .onEnded { value in
                        guard abs(value.translation.height) > height * 0.25 else {
                            return
                        }

                        withAnimation {
                            isOpen = value.translation.height < 0
                        }
                    }
            )
        }
    }
}

#Preview {
    CitySearch(
        isOpen: .constant(true),
        keyboardHeight: .constant(500)
    ) {
        Text("asfas")
    }
}
