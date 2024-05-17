//
//  ProductCellView.swift
//  AppTemplate
//
//  Created by Pieter Jooste on 2024/05/17.
//

import SwiftUI

struct ProductCellView: View {
    
    let product: Product
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            AsyncImage(url: URL(string: product.thumbnail ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 75)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 75, height: 75)
            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)
            
            VStack(alignment: .leading) {
                Text(product.title ?? "n/a")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("$" + String(product.price ?? 0))
                Text("Rating: " + String(product.rating ?? 0))
                Text("Category: " + (product.category ?? "n/a"))
                Text("Brand: " + (product.brand ?? "n/a"))
            }
            .font(.callout)
            .foregroundColor(.secondary)
        }
    }
}

#Preview {
    ProductCellView(product: Product(id: 1, title: "iPhone", description: "Mobile phone", price: 549, discountPercentage: 10, rating: 4.6, stock: 5, brand: "Apple", category: "iPhones", thumbnail: "https://i.dummyjson.com/data/products/1/thumbnail.jpg", images: []))
}
