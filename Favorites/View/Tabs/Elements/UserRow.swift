//
//  UserView.swift
//  Favorites
//
//  Created by Dmytro Horodyskyi on 21.03.2023.
//

import SwiftUI

struct UserRow: View {
    @State private var showRepositories = false
    @ObservedObject private var userViewModel = UserViewModel.shared
    let user: User
    var body: some View {
        ZStack {
            Color("SuperLightGrayColor")
            HStack {
                AsyncImage(url: URL(string: user.avatar_url)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 100, maxHeight: 100)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 100, maxHeight: 100)
                    @unknown default:
                        EmptyView()
                    }
                }
                Text(user.login)
                    .aspectRatio(contentMode: .fill)
                    .font(.system(size: 30))
                    .bold()
                    .frame(alignment: .leading)
                Spacer()
                if userViewModel.favoriteUsers.contains(where: {$0.id == user.id}) {
                    Button {
                        FavoritesDBManager.shared.removeUser(id: user.id)
                        userViewModel.fetchFavoriteUsers()
                    } label: {
                        Image("RemoveFromFavoritesIcon")
                            .resizable()
                    }
                    .frame(width: 32.0, height: 32.0, alignment: .trailing)
                } else {
                    Button {
                        FavoritesDBManager.shared.addUser(id: user.id, login: user.login, avatar_url: user.avatar_url)
                        userViewModel.fetchFavoriteUsers()
                    } label: {
                        Image("FavoritesIcon")
                            .resizable()
                    }
                    .frame(width: 32.0, height: 32.0, alignment: .trailing)
                }
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: .infinity,
                   alignment: .topLeading)
            .padding(.vertical, 2)
            .padding(.horizontal, 10)
        }
        .onTapGesture {
            showRepositories = true
            userViewModel.fetchRepositories(of: user.login)
        }
        .fullScreenCover(isPresented: $showRepositories) {
            RepositoriesView(showRepositories: $showRepositories, login: user.login, userViewModel: userViewModel)
        }
    }
}

