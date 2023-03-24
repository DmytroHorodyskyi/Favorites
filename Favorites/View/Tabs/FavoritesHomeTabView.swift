//
//  FavoritesHomeTabView.swift
//  Favorites
//
//  Created by Dmytro Horodyskyi on 21.03.2023.
//

import SwiftUI

struct FavoritesHomeTabView: View {
    @ObservedObject private var userViewModel = UserViewModel.shared
    var body: some View {
        ScrollView {
            LazyVStack {
                if !userViewModel.favoriteUsers.isEmpty {
                    ForEach(userViewModel.favoriteUsers, id: \.id) { user in
                        UserRow(user: user)
                    }
                } else {
                    Text("You haven't added any favorite user yet")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 25))
                        .bold()
                        .padding(.top, 70)
                }
            }
        }
        .tabItem {
            Image("FavoritesIcon")
            Text("Favorites")
        }
        .onAppear {
            userViewModel.fetchFavoriteUsers()
        }
    }
}
