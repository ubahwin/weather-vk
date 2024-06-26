import SwiftUI

struct VKUITextFieldStyle: TextFieldStyle {
    // swiftlint:disable identifier_name
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(hex: 0xEBEDF0))
                .frame(height: 40)
            HStack {
                Image(systemName: "magnifyingglass")
                    .frame(width: 30)
                    .padding(.leading, 8)
                configuration
            }
        }
    }
    // swiftlint:enable identifier_name
}

#Preview {
    TextField("Поиск", text: .constant(""))
        .textFieldStyle(VKUITextFieldStyle())
        .padding()
}
