import SwiftUI

struct ColorPair {
    private var pair: (Color, Color)

    init(_ firstColor: Color, _ secondColor: Color) {
        pair = (firstColor, secondColor)
    }

    var first: Color {
        pair.0
    }

    var second: Color {
        pair.1
    }

    func calculateAvg() -> Color {
        return Color(
            red: (pair.0.R + pair.1.R) / 2,
            green: (pair.0.G + pair.1.G) / 2,
            blue: (pair.0.B + pair.1.B) / 2
        )
    }
}
