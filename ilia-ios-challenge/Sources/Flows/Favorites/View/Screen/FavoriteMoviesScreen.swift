//
//  FavoriteMoviesScreen.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 07/04/22.
//

import SwiftUI

struct FavoriteMoviesScreen: View {
    /*
     @INSERTION
     The viewModel property was inserted so that we can make requests and pass it on to the next pages
     */
    @EnvironmentObject var viewModel: FavoriteMoviesViewModel
    
    var body: some View {
    
        FavoriteMoviesScreenMainPage()
            .environmentObject(viewModel)
            .onAppear {
                viewModel.loadFavoriteMovies()
            }
    }
}

struct FavoriteMoviesScreen_Previews: PreviewProvider {
    static var previews: some View {
        /*
         @CHANGE
         The following init has been changed to run the preview and insert the viewModel object
         */
        FavoriteMoviesScreen()
            .environmentObject(FavoriteMoviesViewModel(favoriteMoviesRepository: FavoritesRepository()))
    }
}
