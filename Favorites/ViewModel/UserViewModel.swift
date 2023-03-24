//
//  UserViewModel.swift
//  Favorites
//
//  Created by Dmytro Horodyskyi on 21.03.2023.
//

import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    private let usersURLString = "https://api.github.com/users"
    @Published var users: [User] = []
    @Published var repositories: [Repository] = []
    @Published var favoriteUsers: [User] = []
    static var shared = UserViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchFavoriteUsers()
    }
    
    func fetchUsers() {
        guard let url = URL(string: usersURLString) else {
            fatalError("Invalid URL")
        }
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let rootViewController = windowScene.windows.first?.rootViewController else {
                        return
                    }
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            }, receiveValue: { users in
                self.users = users
            })
            .store(in: &cancellables)
    }
    
    func fetchRepositories(of user: String) {
        guard let url = URL(string: usersURLString + "/" + user + "/repos") else {
            fatalError("Invalid URL")
        }
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Repository].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let rootViewController = windowScene.windows.first?.rootViewController else {
                        return
                    }
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            }, receiveValue: { repositories in
                self.repositories = repositories
            })
            .store(in: &cancellables)
    }
    
    func fetchFavoriteUsers() {
        self.favoriteUsers = FavoritesDBManager.shared.getUsers()
    }
}
