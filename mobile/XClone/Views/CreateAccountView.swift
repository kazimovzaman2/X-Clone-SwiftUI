//
//  CreateAccountView.swift
//  XClone
//
//  Created by Zaman Kazimov on 19.01.25.
//

import SwiftUI

struct CreateAccountView: View {
    @State private var user = CreateAccountData()
    @State private var isEmailValid = true
    @FocusState private var focusedField: Field?
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode

    @Binding var isAuthenticated: Bool
    
    enum Field: Hashable {
        case firstName, lastName, email, password
    }

    private var isFormValid: Bool {
        !user.firstName.isEmpty && !user.lastName.isEmpty && !user.email.isEmpty && !user.password.isEmpty
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
            .padding()


            Text("Create Your Account")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 40)

            Spacer()

            VStack(spacing: 20) {
                TextField("First Name", text: $user.firstName)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(height: 55)
                    .padding([.horizontal], 7)
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(focusedField == .firstName ? Color.blue : Color.gray.opacity(0.8)))
                    .focused($focusedField, equals: .firstName)

                TextField("Last Name", text: $user.lastName)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(height: 55)
                    .padding([.horizontal], 7)
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(focusedField == .lastName ? Color.blue: Color.gray.opacity(0.8)))
                    .focused($focusedField, equals: .lastName)

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
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(focusedField == .password ? Color.blue: Color.gray.opacity(0.8)))
                    .focused($focusedField, equals: .password)
            }
            .padding(.horizontal, 40)

            Spacer()

            Divider()
                .frame(height: 1)
                .background(Color.gray.opacity(0.2))

            HStack {
                Spacer()
                Button(action: {
                    isEmailValid = user.email.isValidEmail

                    if isEmailValid {
                        isAuthenticated = true
                    }
                }) {
                    Text("Create")
                        .fontWeight(.bold)
                        .frame(width: 80, height: 40)
                        .background(isFormValid ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .padding(.horizontal, 20)
                }
                .disabled(!isFormValid)
            }
        }
        .onAppear {
            user = CreateAccountData()
        }
    }
}

#Preview {
    CreateAccountView(isAuthenticated: .constant(false))
}
