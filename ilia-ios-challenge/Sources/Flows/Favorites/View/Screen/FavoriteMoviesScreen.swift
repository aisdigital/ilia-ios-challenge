//
//  FavoriteMoviesScreen.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 07/04/22.
//

import SwiftUI

struct FavoriteMoviesScreen: View {
    
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
        FavoriteMoviesScreen()
    }
}
