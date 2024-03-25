import SwiftUI

struct SmallLine: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(hex: 0x76787A, alpha: 0.2))
            .frame(height: 1)
            .padding(.horizontal)
    }
}
