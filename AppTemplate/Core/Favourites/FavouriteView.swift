//
//  FavouriteView.swift
//  AppTemplate
//
//  Created by Pieter Jooste on 2024/05/22.
//

import SwiftUI

@MainActor
final class FavouriteViewModel: ObservableObject {
    
    @Published private(set) var userFavouriteProducts: [UserFavouriteProduct] = []
    
    func getFavourites() {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            self.userFavouriteProducts = try await UserManager.shared.getAllUserFavouriteProducts(userId: authDataResult.uid)
            
        }
    }
    
    func removeFromFavourites(favouriteProductId: String) {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.removeUserProduct(userId: authDataResult.uid, favouriteProductId: favouriteProductId)
            getFavourites()
        }
    }
}

struct FavouriteView: View {
    
    @StateObject private var viewModel = FavouriteViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.userFavouriteProducts, id: \.id.self) { item in
                ProductCellViewBuilder(productId: String(item.productId))
                    .contextMenu {
                        Button("Remove from Favourites") {
                            viewModel.removeFromFavourites(favouriteProductId: item.id)
                        }
                    }
            }
        }
        .navigationTitle("Favourites")
        .onAppear {
            viewModel.getFavourites()
        }
    }
}

#Preview {
    NavigationStack {
        FavouriteView()
    }
   
}
