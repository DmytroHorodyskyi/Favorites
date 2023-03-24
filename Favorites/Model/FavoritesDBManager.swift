//
//  FavoritesDB.swift
//  Favorites
//
//  Created by Dmytro Horodyskyi on 24.03.2023.
//

import Foundation
import SQLite

class FavoritesDBManager {
    private var database: Connection?
    private let users = Table("users")
    private let id = Expression<Int>("id")
    private let login = Expression<String>("login")
    private let avatar_url = Expression<String>("avatar_url")
    static let shared = FavoritesDBManager()
    
    init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            database = try Connection("\(path)/Favorites.db")
        }
        catch {
            print("Error connecting to database: \(error)")
            database = nil
        }
        let tableExists = try! database!.scalar(users.exists)
        guard !tableExists else {
            return
        }
        createTable()
    }
    
    private func createTable() {
        do {
            try database?.run(users.create { table in
                table.column(id, primaryKey: true)
                table.column(login)
                table.column(avatar_url)
            })
        } catch {
            print("Error creating table: \(error)")
        }
    }
    
    func addUser(id: Int, login: String, avatar_url: String) {
        let insert = users.insert(self.id <- id, self.login <- login, self.avatar_url <- avatar_url)
        do {
            try database?.run(insert)
        } catch {
            print("Error adding user: \(error)")
        }
    }
    
    func getUsers() -> [User] {
        var users = [User]()
        do {
            for user in try database!.prepare(self.users) {
                users.append(User(id: user[id], login: user[login], avatar_url: user[avatar_url]))
            }
        } catch {
            print("Error retrieving users: \(error)")
        }
        return users
    }
    
    func removeUser(id: Int) {
        let user = users.filter(self.id == id)
        let deleteUser = user.delete()
        do {
            try database?.run(deleteUser)
        } catch {
            print("Error deleting user: \(error)")
        }
    }
}
