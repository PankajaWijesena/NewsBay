//
//  SignUpView.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var persistence: SwiftDataPersistenceService
    @StateObject private var viewModel = SignUpViewModel(repository: RemoteAuthRepository())
    @State private var isPasswordVisible = false
    @State private var isProgressIndicatorShown = false
    @State private var isAlertShown = false
    @State private var alertMessage: String = ""
    @Binding var isLoggedIn: Bool

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 20) {
                LoginBanner()
                    .frame(height: 300)
                VStack(alignment: .center, spacing: 20) {
                    Text("Sign Up")
                        .font(.customFont(.lexend500, size: 22))
                        .foregroundStyle(Color.onSurface)
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
                    PrimaryButton(
                        title: "Sign Up",
                        action: signUpAction
                    )
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
            if isProgressIndicatorShown {
                ProgressView()
            }
        }
        .allowsHitTesting(!isProgressIndicatorShown)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButton(tint: Color.onSurface)
            }
        }
        .alert("Alert", isPresented: $isAlertShown) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
}

extension SignUpView {
    private func signUpAction() {
        Task {
            isProgressIndicatorShown = true
            do {
                try await viewModel.performSignUp(persistence: persistence)
                withAnimation {
                    isLoggedIn = true
                }
            } catch {
                if error is LoginValidationError {
                    alertMessage = error.localizedDescription
                } else {
                    print(error.localizedDescription)
                    alertMessage = "Sign Up Failed."
                }
                isAlertShown = true
            }
            isProgressIndicatorShown = false
        }
    }
}

#Preview("Sign Up") {
    NavigationStack {
        SignUpView(isLoggedIn: .constant(false))
    }
}
