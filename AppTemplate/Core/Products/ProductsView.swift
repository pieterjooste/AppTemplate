//
//  ProductsView.swift
//  AppTemplate
//
//  Created by Pieter Jooste on 2024/05/17.
//

import SwiftUI

@MainActor
final class ProductsViewModel: ObservableObject {
        
    @Published private(set) var products: [Product] = []
    
    func getAllProducts() async throws {
        self.products = try await ProductsManager.shared.getAllProducts()
    }
        
}

struct ProductsView: View {
    
    @StateObject private var viewModel = ProductsViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.products) { product in
                ProductCellView(product: product)
            }
        }
        .navigationTitle("Products")
        .task {
            try? await viewModel.getAllProducts()
        }
    }
}

#Preview {
    NavigationStack {
        ProductsView()
    }
   
}