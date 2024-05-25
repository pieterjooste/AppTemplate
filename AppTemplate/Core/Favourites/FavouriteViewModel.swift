//
//  FavouriteViewModel.swift
//  AppTemplate
//
//  Created by Pieter Jooste on 2024/05/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class FavouriteViewModel: ObservableObject {
    
    @Published private(set) var userFavouriteProducts: [UserFavouriteProduct] = []
    private var cancellables = Set<AnyCancellable>()
    
    func addListenerForFavourites() {
        guard let authDataResult = try? AuthenticationManager.shared.getAuthenticatedUser() else { return }
        
//        UserManager.shared.addListenerForAllUserFavouriteProducts(userId: authDataResult.uid) { [weak self] products in
//            self?.userFavouriteProducts = products
//        }
        
        UserManager.shared.addListenerForAllUserFavouriteProducts(userId: authDataResult.uid)
            .sink { completion in
                
            } receiveValue: { [weak self] products in
                self?.userFavouriteProducts = products
            }
            .store(in: &cancellables)
    }
    
//    func getFavourites() {
//        Task {
//            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
//            self.userFavouriteProducts = try await UserManager.shared.getAllUserFavouriteProducts(userId: authDataResult.uid)
//
//        }
//    }
    
    func removeFromFavourites(favouriteProductId: String) {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.removeUserProduct(userId: authDataResult.uid, favouriteProductId: favouriteProductId)
        }
    }
}
