//
//  HomeTabView.swift
//  Favorites
//
//  Created by Dmytro Horodyskyi on 21.03.2023.
//

import SwiftUI

struct HomeTabView: View {
    @ObservedObject private var userViewModel = UserViewModel.shared
    var body: some View {
        ScrollView {
            LazyVStack {
                if !userViewModel.users.isEmpty {
                    ForEach(userViewModel.users, id: \.id) { user in
                        UserRow(user: user)
                    }
                } else {
                    Text("Loading...")
                }
            }
        }
        .tabItem {
            Image("HomeIcon")
            Text("Home")
        }
        .onAppear {
            userViewModel.fetchUsers()
        }
    }
}

