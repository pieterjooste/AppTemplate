//
//  FavouriteView.swift
//  AppTemplate
//
//  Created by Pieter Jooste on 2024/05/22.
//
import SwiftUI

struct FavouriteView: View {
    
    @StateObject private var viewModel = FavouriteViewModel()
    @State private var didAppear: Bool = false
    
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
            if !didAppear {
                viewModel.addListenerForFavourites()
                didAppear = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        FavouriteView()
    }
   
}
