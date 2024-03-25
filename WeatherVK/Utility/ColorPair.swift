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

    func calculateContrastColor() -> Color {
        let avgColor = calculateAvg()

        let luminance = 0.299 * avgColor.R + 0.587 * avgColor.G + 0.114 * avgColor.B

        return luminance > 0.5 ? Color(hex: 0x070820) : Color(hex: 0xf3f3f3)
    }
}
