import SwiftUI
import CoreMotion

struct Theme: View {
    let motionManager = CMMotionManager()
    @State private var offset = CGSize()

    let weatherType: WeatherType

    let colors: ColorPair

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: .init(colors: [
                    colors.first,
                    colors.second
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .opacity(0.9)

            VStack {
                HStack {
                    ForEach(0..<5) { i in
                        Text(weatherType.image)
                            .frame(width: 100, height: 20)
                            .font(i == 2 ? .system(size: 50) : .callout)
                    }
                }
                HStack {
                    ForEach(0..<5) { _ in
                        Text(weatherType.image)
                            .frame(width: 100, height: 20)
                    }
                    .offset(x: 50)
                }
                HStack {
                    ForEach(0..<5) { i in
                        Text(weatherType.image)
                            .frame(width: 100, height: 20)
                            .font(i == 1 || i == 3 ? .system(size: 50) : .callout)
                    }
                }
                HStack {
                    ForEach(0..<5) { _ in
                        Text(weatherType.image)
                            .frame(width: 100, height: 20)
                    }
                    .offset(x: 50)
                }
                HStack {
                    ForEach(0..<5) { i in
                        Text(weatherType.image)
                            .frame(width: 100, height: 20)
                            .font(i == 2 ? .system(size: 50) : .callout)
                    }
                }
                HStack {
                    ForEach(0..<5) { _ in
                        Text(weatherType.image)
                            .frame(width: 100, height: 20)
                    }
                    .offset(x: 50)
                }
                HStack {
                    ForEach(0..<5) { i in
                        Text(weatherType.image)
                            .frame(width: 100, height: 20)
                            .font(i == 1 || i == 3 ? .system(size: 50) : .callout)
                    }
                }
                HStack {
                    ForEach(0..<5) { _ in
                        Text(weatherType.image)
                            .frame(width: 100, height: 20)
                    }
                    .offset(x: 50)
                }
            }
        }
        .frame(width: 0, height: 0)
        .offset(offset)
        .frame(width: 300, height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(color: colors.calculateAvg(), radius: 10, y: 10)
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

                self.offset = CGSize(width: roll * 8, height: pitch * 8)
            }
        } else {
            print("Device motion is not available")
        }
    }
}

#Preview {
    Theme(
        weatherType: .clearSky,
        colors: ColorPair(.white, .blue)
    )
}
