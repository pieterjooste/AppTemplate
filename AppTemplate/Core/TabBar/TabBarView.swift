//
//  TabBarView.swift
//  AppTemplate
//
//  Created by Pieter Jooste on 2024/05/22.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        TabView {
            NavigationStack {
                ProductsView()
            }
            .tabItem {
                Image(systemName: "cart")
                Text("Products")
            }
            
            NavigationStack {
                FavouriteView()
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("Favourites")
            }
            
            NavigationStack {
                ProfileView(showSignInView: $showSignInView)
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }
    }
}

#Preview {
    TabBarView(showSignInView: .constant(false))
}
