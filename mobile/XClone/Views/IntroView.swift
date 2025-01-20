//
//  LoginView.swift
//  XClone
//
//  Created by Zaman Kazimov on 19.01.25.
//

import SwiftUI

struct IntroView: View {
    @Binding var isAuthenticated: Bool
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(colorScheme == .light ? "logoWhiteMode" : "logoDarkMode")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
                .padding()

                Spacer()

                Text("See what's happening in the world right now.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                VStack(spacing: 8) {
                    NavigationLink(destination: LoginView(isAuthenticated: $isAuthenticated)) {
                        HStack {
                            Image("googleLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)

                            Text("Continue with Google")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.white)
                        .cornerRadius(30)
                        .overlay {
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                        }
                    }

                    LabelledDivider(label: "or")

                    NavigationLink(destination: CreateAccountView(isAuthenticated: $isAuthenticated)) {
                        Text("Create Account")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(colorScheme == .light ? .black : .white)
                            .foregroundColor(colorScheme == .light ? .white : .black)
                            .cornerRadius(30)
                    }
                }

                Text("""
                     By signing up, you agree to our [Terms](https://x.com/en/tos), [Privacy Policy](https://x.com/en/privacy), and [Cookie Use](https://help.x.com/en/rules-and-policies/x-cookies#:~:text=Cookies%20and%20similar%20technologies%20like,%2C%20embeds%2C%20and%20email%20communications.).
                     """)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                    .frame(maxWidth: .infinity, alignment: .leading)


                HStack (spacing: 3) {
                    Text("Have an account already?")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    NavigationLink(destination: LoginView(isAuthenticated: $isAuthenticated)) {
                        Text("Log in")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    IntroView(isAuthenticated: .constant(false))
}
