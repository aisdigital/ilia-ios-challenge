//
//  IICTabBarScreen.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 04/04/22.
//

import SwiftUI

struct IICTabBarScreen: View {
    private var moviesRepository: MoviesRepositoryProtocol
    private var favoritesRepository: FavoritesRepositoryProtocol
    private var favoriteMoviesViewModel: FavoriteMoviesViewModel
    private var homeMoviesViewModel: HomeMoviesViewModel
    
    init() {
        self.moviesRepository = MoviesRepository(movieProvider: MovieProvider())
        self.favoritesRepository = FavoritesRepository()
        self.favoriteMoviesViewModel = FavoriteMoviesViewModel(favoriteMoviesRepository: favoritesRepository)
        self.homeMoviesViewModel = HomeMoviesViewModel(moviesRepository: moviesRepository)
    }
    
    var body: some View {
        TabView {
            HomeMoviesScreen()
                .background(IICUIKit.backGroundColor)
                .environmentObject(self.homeMoviesViewModel)
                .environmentObject(self.favoriteMoviesViewModel)
                .tabItem {
                    Label("Home Movies", systemImage: "film")
                }
            
            FavoriteMoviesScreen().environmentObject(self.favoriteMoviesViewModel)
                .tabItem {
                    Label("Favorite Movies", systemImage: "star")
                }
        }
    }
}

struct IICTabBarScreen_Previews: PreviewProvider {
    static var previews: some View {
        IICTabBarScreen()
    }
}

