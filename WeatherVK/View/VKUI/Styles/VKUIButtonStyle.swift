import SwiftUI

struct VKUIButtonStyle: ButtonStyle {
    var fixHeight: CGFloat?

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: fixHeight)
            .background(Color(hex: 0x2D81E0))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundStyle(.white)
            .padding()
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .brightness(configuration.isPressed ? -0.1: 0)
    }
}

#Preview {
    Button("Button") { }
        .buttonStyle(VKUIButtonStyle())
}
