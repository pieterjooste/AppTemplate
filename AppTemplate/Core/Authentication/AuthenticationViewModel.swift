//
//  AuthenticationViewModel.swift
//  AppTemplate
//
//  Created by Pieter Jooste on 2024/05/14.
//

import Foundation


@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    let signInAppleHelper = SignInAppleHelper()

    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
//        try await UserManager.shared.createNewUser(auth: authDataResult)
        
    }
    
    func signInApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
//    func signInAnonymus() async throws {
//        let authDataResult = try await AuthenticationManager.shared.signInAnonymus()
//        let user = DBUser(auth: authDataResult)
//        try await UserManager.shared.createNewUser(user: user)
//    }
    
}
