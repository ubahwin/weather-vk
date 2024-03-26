import SwiftUI
import CoreMotion

struct Cloud<Content: View>: View {
    let content: Content
    let width: CGFloat
    let height: CGFloat
    let moveRetio: CGFloat

    let motionManager = CMMotionManager()

    @State private var offset = CGSize(width: 0, height: 0)
    @State private var rectanglePosition: CGSize = .zero

    init(width: CGFloat, height: CGFloat, moveRetio: CGFloat = 0, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.width = width
        self.height = height
        self.moveRetio = moveRetio
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .shadow(color: Color(hex: 0xf00008B, alpha: 0.1), radius: 4, y: 5)
            content
        }
        .frame(width: width, height: height)
        .offset(offset)
        .offset(x: rectanglePosition.width, y: rectanglePosition.height)
        .animation(.bouncy, value: offset)
        .gesture(DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                }
            }
        )
        .onAppear {
            startMotionUpdates()
        }
    }

    private func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            motionManager.startDeviceMotionUpdates(to: .main) { (data, _) in
                guard let data = data else { return }
                let attitude = data.attitude

                let pitch = CGFloat(attitude.pitch)
                let roll = CGFloat(attitude.roll)

                self.rectanglePosition = CGSize(width: roll * moveRetio, height: pitch * moveRetio)
            }
        } else {
            Log.info("Device motion is not available")
        }
    }
}
