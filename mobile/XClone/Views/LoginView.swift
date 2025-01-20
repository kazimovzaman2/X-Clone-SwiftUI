//
//  LoginView.swift
//  XClone
//
//  Created by Zaman Kazimov on 19.01.25.
//

import SwiftUI

struct LoginView: View {
    @State private var user = LoginData()
    @State private var isEmailValid = true
    @FocusState private var focusedField: Field?
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode

    enum Field: Hashable {
        case email, password
    }

    private var isFormValid: Bool {
        !user.email.isEmpty && !user.password.isEmpty
    }

    var body: some View {
        VStack(spacing: 20) {

            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(colorScheme == .light ? .black : .white)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)

                Image(colorScheme == .light ? "logoWhiteMode" : "logoDarkMode")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity, alignment: .center)

                Spacer()
                    .frame(maxWidth: .infinity)
            }
            .navigationBarBackButtonHidden(true)

            Text("Log in the app to continue")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 40)

            Spacer()

            VStack(spacing: 20) {
                TextField("Email", text: $user.email)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(height: 55)
                    .padding([.horizontal], 7)
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(isEmailValid ? (focusedField == .email ? Color.blue : Color.gray.opacity(0.8)) : Color.red, lineWidth: 0.8))
                    .focused($focusedField, equals: .email)
                    .keyboardType(.emailAddress)

                SecureField("Password", text: $user.password)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(height: 55)
                    .padding([.horizontal], 7)
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(focusedField == .password ? Color.blue : Color.gray.opacity(0.8)))
                    .focused($focusedField, equals: .password)
            }
            .padding(.horizontal, 40)

            Spacer()
            Spacer()

            Divider()
                .frame(height: 1)
                .background(Color.gray.opacity(0.2))

            HStack {
                Spacer()
                Button(action: {
                    isEmailValid = user.email.isValidEmail

                    if isEmailValid {
                        print("Log In button tapped")
                    }
                }) {
                    Text("Log In")
                        .fontWeight(.bold)
                        .frame(width: 90, height: 40)
                        .background(isFormValid ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .padding(.horizontal, 20)
                }
                .disabled(!isFormValid)
            }
        }
        .onAppear {
            user = LoginData()
        }
    }
}

#Preview {
    LoginView()
}
