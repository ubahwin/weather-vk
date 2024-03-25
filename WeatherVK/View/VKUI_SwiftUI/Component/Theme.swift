import SwiftUI

struct Theme: View {
    let weatherType: WeatherType
    let date: Date

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: .init(colors: [
                    .white,
                    date.isDaytime ? .blue : .black
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
    }
}

#Preview {
    Theme(weatherType: .clearSky, date: .now)
}
