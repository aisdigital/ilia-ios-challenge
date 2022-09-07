//
//  IICTabBarScreen.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 04/04/22.
//

import SwiftUI

/*
 @INSERTION
 This enum has been inserted to fix the navigation view problem
 */
enum Tabs: String {
    case home = "Incoming Movies"
    case favorite = "Favorite Movies"
}

struct IICTabBarScreen: View {
    private var moviesRepository: MoviesRepositoryProtocol
    private var favoritesRepository: FavoritesRepositoryProtocol
    private var favoriteMoviesViewModel: FavoriteMoviesViewModel
    private var homeMoviesViewModel: HomeMoviesViewModel
    
    /*
     @INSERTION
     this code has been inserted to manage the selected tab and change the navigation title
     */
    @State var selectedTab: Tabs = .home
    
    init() {
        self.moviesRepository = MoviesRepository(movieProvider: MovieProvider())
        self.favoritesRepository = FavoritesRepository()
        self.favoriteMoviesViewModel = FavoriteMoviesViewModel(favoriteMoviesRepository: favoritesRepository)
        self.homeMoviesViewModel = HomeMoviesViewModel(moviesRepository: moviesRepository)
    }
    
    var body: some View {
        /*
         @CHANGE
         Insert navigation view to configure properly the navigation bar for each selected tab
         */
        NavigationView {
            TabView(selection: $selectedTab) {
                HomeMoviesScreen()
                    .background(IICUIKit.backGroundColor)
                    .environmentObject(self.homeMoviesViewModel)
                    .environmentObject(self.favoriteMoviesViewModel)
                    .tabItem {
                        Label("Home Movies", systemImage: "film")
                    }
                    .tag(Tabs.home)
                
                FavoriteMoviesScreen()
                    /*
                     @INSERTION
                     The background modifier was added in order to follow the design
                     */
                    .background(IICUIKit.backGroundColor)
                    .environmentObject(self.favoriteMoviesViewModel)
                    .tabItem {
                        Label("Favorite Movies", systemImage: "star")
                    }
                    .tag(Tabs.favorite)
            }
            /*
             @INSERTION
             Made to fix the color of the tab bar and items
             */
            .tabBarColor(backgroundColor: IICUIKit.navigationBarColor, selectedItemColor: IICUIKit.secondaryColor, unselectedItemColor: IICUIKit.backGroundColor)
            .navigationTitle(selectedTab.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: IICUIKit.navigationBarColor, titleColor: IICUIKit.secondaryColor)
        }
        
    }
}

struct IICTabBarScreen_Previews: PreviewProvider {
    static var previews: some View {
        IICTabBarScreen()
    }
}

