//
//  LoginView.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var persistence: SwiftDataPersistenceService
    @StateObject private var viewModel = LoginViewModel(repository: RemoteAuthRepository())
    @State private var alertMessage: String = ""
    @State private var isAlertShown = false
    @State private var isPasswordVisible = false
    @State private var isNavigatingToSignUp = false
    @State private var isProgressIndicatorShown = false
    @Binding var isLoggedIn: Bool

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .center, spacing: 20) {
                    
                    // MARK: - HEADER SECTION
                    LoginBanner()
                        .frame(height: 300)
                    
                    VStack(alignment: .center, spacing: 20) {
                        // MARK: - GREETING TEXT
                        Text("Welcome Back")
                            .font(.customFont(.lexend500, size: 22))
                            .foregroundStyle(Color.onSurface)
                        
                        // MARK: - INPUT FIELDS SECTION
                        VStack(alignment: .center, spacing: 12) {
                            InputField(
                                text: $viewModel.username,
                                placeholder: "Email Address"
                            )
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            PasswordField(
                                text: $viewModel.password,
                                placeholder: "Password"
                            )
                            .autocapitalization(.none)
                        }
                        HStack(alignment: .center, spacing: 0) {
                            CheckBox(
                                value: $viewModel.rememberUser,
                                title: "Remember me"
                            )
                            Spacer(minLength: 16)
                            TextButton(
                                title: "Forgot password?",
                                action: forgotPasswordAction
                            )
                            .font(.customFont(.lexend300, size: 12))
                            .foregroundStyle(Color.primary1)
                        }
                        .font(.footnote)
                        
                        // MARK: - LOGIN BUTTONS SECTION
                        PrimaryButton(
                            title: "Login",
                            action: loginAction
                        )
                        Text("Or")
                            .font(.customFont(.lexend300, size: 16))
                            .foregroundStyle(Color.secondary)
                            .frame(maxWidth: .infinity)
                        GoogleLoginButton(
                            action: loginWithGoogleAction
                        )
                        
                        // MARK: - SIGNUP BUTTONS SECTION
                        HStack(alignment: .center, spacing: 8) {
                            Text("Not a member?")
                                .font(.customFont(.lexend400, size: 14))
                                .foregroundStyle(Color.secondary)
                            TextButton(
                                title: "Sign up",
                                action: signUpAction
                            )
                            .font(.customFont(.lexend500, size: 14))
                            .foregroundStyle(Color.primary1)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.horizontal, 16)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background {
                    Color.customWhite
                        .ignoresSafeArea(edges: .all)
                }
            }
            .scrollIndicators(.hidden)
            .scrollBounceBehavior(.basedOnSize)
            .ignoresSafeArea(edges: .top)
            .overlay {
                // MARK: - LOADING PROGRESS INDICATOR
                if isProgressIndicatorShown {
                    ProgressView()
                }
            }
            .allowsHitTesting(!isProgressIndicatorShown)
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $isNavigatingToSignUp) {
                SignUpView(isLoggedIn: $isLoggedIn)
            }
            .alert("Alert", isPresented: $isAlertShown) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
}

extension LoginView {
    private func loginAction() {
        Task {
            isProgressIndicatorShown = true
            do {
                try await viewModel.performLogin(persistence: persistence)
                withAnimation {
                    isLoggedIn = true
                }
            } catch {
                if error is LoginValidationError {
                    alertMessage = error.localizedDescription
                } else {
                    print(error.localizedDescription)
                    alertMessage = "Login Failed."
                }
                isAlertShown = true
            }
            isProgressIndicatorShown = false
        }
    }
    
    private func forgotPasswordAction() {
        // TODO: Forgot Password Action
    }

    private func loginWithGoogleAction() {
        // TODO: Login with Google
    }

    private func signUpAction() {
        isNavigatingToSignUp.toggle()
    }
}

#Preview("Login") {
    NavigationStack {
        LoginView(isLoggedIn: .constant(false))
        .preferredColorScheme(.light)
    }
}
