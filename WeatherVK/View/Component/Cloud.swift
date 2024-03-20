import SwiftUI

struct Cloud<Content: View>: View {
    let content: Content
    let width: CGFloat
    let height: CGFloat

    @State private var offset = CGSize(width: 0, height: 0)

    init(width: CGFloat, height: CGFloat, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.width = width
        self.height = height
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .shadow(radius: 4, y: 5)
            content
        }
        .frame(width: width, height: height)
        .offset(offset)
        .animation(.bouncy, value: offset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    offset = value.translation
                }
                .onEnded { _ in
                    withAnimation {
                        offset = .zero
                    }
                }
            )
    }
}
