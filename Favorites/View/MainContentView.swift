//
//  ContentView.swift
//  Favorites
//
//  Created by Dmytro Horodyskyi on 21.03.2023.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        TabView {
            HomeTabView()
            FavoritesHomeTabView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
