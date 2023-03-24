//
//  RepositoriesView.swift
//  Favorites
//
//  Created by Dmytro Horodyskyi on 23.03.2023.
//

import SwiftUI

struct RepositoriesView: View {
    @Binding var showRepositories: Bool
    var login: String
    var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Back") {
                    showRepositories = false
                }
                .padding()
            }
            Text(login + "'s repositories:")
                .font(.system(size: 28))
                .bold()
            ScrollView {
                LazyVStack {
                    if !userViewModel.repositories.isEmpty {
                        ForEach(userViewModel.repositories, id: \.id) { repository in
                            if let url = URL(string: repository.html_url) {
                                Link(repository.name, destination: url)
                                    .font(.system(size: 25))
                                    .bold()
                                    .frame(alignment: .leading)
                                    .frame(minWidth: 0,
                                           maxWidth: .infinity,
                                           minHeight: 0,
                                           maxHeight: .infinity,
                                           alignment: .topLeading)
                                    .padding(.vertical, 2)
                                    .padding(.horizontal, 16)
                            }
                            else {
                                Text(repository.name)
                                    .font(.system(size: 25))
                                    .bold()
                                    .frame(alignment: .leading)
                                    .frame(minWidth: 0,
                                           maxWidth: .infinity,
                                           minHeight: 0,
                                           maxHeight: .infinity,
                                           alignment: .topLeading)
                                    .padding(.vertical, 2)
                                    .padding(.horizontal, 16)
                            }
                        }
                    } else {
                        Text("Loading...")
                    }
                }
            }
        }
    }
}
