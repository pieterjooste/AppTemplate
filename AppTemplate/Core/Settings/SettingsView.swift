//
//  SettingsView.swift
//  AppTemplate
//
//  Created by Pieter Jooste on 2024/05/07.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("Sign out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button(role: .destructive) {
                Task {
                    do {
                        try await viewModel.deleteAccount()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Delete account")
            }
            
            
            if viewModel.authProviders.contains(.email) {
                emailSection
            }
           
            
        }
        .onAppear {
            viewModel.loadAuthProviders()
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
    
}

extension SettingsView {
    
    private var emailSection: some View {
        
        Section {
            Button("Reset password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("PASSWORD RESET!")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Update password") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("PASSWORD UPDATED!")
                    } catch {
                        print(error)
                    }
                }
            }
            
//            Button("Update email") {
//                Task {
//                    do {
//                        try await viewModel.updateEmail()
//                        print("EMAIL UPDATED!")
//                    } catch {
//                        print(error)
//                    }
//                }
//            }
        } header: {
            Text("E-mail functions")
        }
    }
}
