//
//  CustomTextField.swift
//  XClone
//
//  Created by Zaman Kazimov on 19.01.25.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(height: 55)
                    .padding([.horizontal], 7)
                    .cornerRadius(5)
            } else {
                TextField(placeholder, text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(height: 55)
                    .padding([.horizontal], 7)
                    .cornerRadius(5)
            }
        }
    }
}

#Preview {
    CustomTextField(placeholder: "Test", text: .constant("Test"))
}
