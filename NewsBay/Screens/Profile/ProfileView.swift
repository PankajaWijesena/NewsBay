//
//  ProfileView.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var persistence: SwiftDataPersistenceService
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var isLoggedIn: Bool

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    
                    // MARK: - USER DETAILS SECTION
                    VStack(alignment: .center, spacing: 16) {
                        AvatarPlaceholder(
                            text: "EH",
                            foregroundColor: Color.customBlue,
                            backgroundColor: Color.customWhite,
                        )
                        .font(.customFont(.lexend400, size: 28))
                        .frame(width: 96, height: 96)
                        .overlay(alignment: .bottomTrailing) {
                            Button(action: profileImagePickerAction) {
                                Circle()
                                    .fill(Color.secondary)
                                    .frame(width: 24, height: 24)
                                    .overlay(alignment: .center) {
                                        Image(systemName: "camera.fill")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundStyle(Color.customWhite)
                                            .scaledToFit()
                                            .frame(height: 10)
                                    }
                            }
                        }
                        Text("Esther Howard")
                            .font(.customFont(.lexend600, size: 20))
                            .foregroundStyle(Color.onSurface)
                    }
                    .padding(.bottom, 40)
                    
                    // MARK: - PROFILE OPTIONS SECTION
                    VStack(alignment: .center, spacing: 0) {
                        ForEach(ProfileOption.allCases) { option in
                            ProfileOptionCard(
                                icon: option.image,
                                title: option.title,
                                iconColor: Color.secondary,
                                textColor: Color.onSurface,
                            )
                        }
                    }
                    Spacer(minLength: 0)
                    
                    // MARK: - LOG OUT BUTTON
                    Button(action: logOutAction) {
                        ProfileOptionCard(
                            icon: Image(.poweroff),
                            title: "Log Out",
                            iconColor: Color.critical,
                            textColor: Color.critical,
                        )
                        .foregroundStyle(Color.critical)
                    }
                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .scrollIndicators(.hidden)
            .scrollContentBackground(.visible)
            .scrollBounceBehavior(.basedOnSize)
            .background {
                Color.surface
                    .ignoresSafeArea(.all)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension ProfileView {
    func profileImagePickerAction() {
        // TODO: Select Profile image
    }

    func logOutAction() {
        do {
            try viewModel.logOut(persistence: persistence)
        } catch {
            print(error.localizedDescription)
        }
        withAnimation {
            isLoggedIn = false
        }
    }
}

#Preview("Profile") {
    ProfileView(isLoggedIn: .constant(true))
        .preferredColorScheme(.light)
}
