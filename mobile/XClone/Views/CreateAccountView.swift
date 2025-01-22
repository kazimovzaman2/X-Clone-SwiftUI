//
//  CreateAccountView.swift
//  XClone
//
//  Created by Zaman Kazimov on 19.01.25.
//

import SwiftUI

struct CreateAccountView: View {
    @StateObject private var viewModel: CreateAccountViewModel
    @FocusState private var focusedField: Field?
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    enum Field: Hashable {
        case firstName, lastName, email, password
    }
    
    init(authStateManager: AuthStateManager = .shared) {
        _viewModel = StateObject(wrappedValue: CreateAccountViewModel(authStateManager: authStateManager))
    }
    
    var body: some View {
        ZStack {
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
                    TextField("First Name", text: $viewModel.user.firstName)
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(height: 55)
                        .padding([.horizontal], 7)
                        .cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(focusedField == .firstName ? Color.blue : Color.gray.opacity(0.8)))
                        .focused($focusedField, equals: .firstName)
                        .onChange(of: viewModel.user.firstName) { _, _ in
                            viewModel.validateForm()
                        }
                    
                    TextField("Last Name", text: $viewModel.user.lastName)
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(height: 55)
                        .padding([.horizontal], 7)
                        .cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(focusedField == .lastName ? Color.blue: Color.gray.opacity(0.8)))
                        .focused($focusedField, equals: .lastName)
                        .onChange(of: viewModel.user.lastName) { _, _ in
                            viewModel.validateForm()
                        }
                    
                    TextField("Email", text: $viewModel.user.email)
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(height: 55)
                        .padding([.horizontal], 7)
                        .cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(viewModel.isEmailValid ? (focusedField == .email ? Color.blue : Color.gray.opacity(0.8)) : Color.red, lineWidth: 0.8))
                        .focused($focusedField, equals: .email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .onChange(of: viewModel.user.email) { _, _ in
                            viewModel.validateEmail()
                            viewModel.validateForm()
                        }
                    
                    SecureField("Password", text: $viewModel.user.password)
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(height: 55)
                        .padding([.horizontal], 7)
                        .cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(focusedField == .password ? Color.blue: Color.gray.opacity(0.8)))
                        .focused($focusedField, equals: .password)
                        .onChange(of: viewModel.user.password) { _, _ in
                            viewModel.validateForm()
                        }
                }
                .padding(.horizontal, 40)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray.opacity(0.2))
                
                HStack {
                    Spacer()
                    Button(action: {
                        Task {
                            await viewModel.register()
                        }
                    }) {
                        Text("Create")
                            .fontWeight(.bold)
                            .frame(width: 80, height: 40)
                            .background(viewModel.isFormValid ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(50)
                            .padding(.horizontal, 20)
                    }
                    .disabled(!viewModel.isFormValid)
                }
            }
            
            if viewModel.isLoading {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
        }
        
    }
}

#Preview {
    CreateAccountView(authStateManager: AuthStateManager.shared)
}
