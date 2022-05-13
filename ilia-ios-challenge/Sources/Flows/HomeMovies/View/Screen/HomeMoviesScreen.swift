//
//  HomeMoviesScreen.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import SwiftUI

struct HomeMoviesScreen: View {
    @EnvironmentObject private var viewModel: HomeMoviesViewModel
    @EnvironmentObject private var favoriteViewModel: FavoriteMoviesViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            HomeMoviesScreenEmptyPage()
                .onAppear {
                    await self.viewModel.loadMovies(page: 1)
                }
        case .loading:
            HomeMoviesScreenLoadingPage()
        case .loaded:
            if viewModel.hasMovies() {
                HomeMoviesScreenMainPage()
                    .environmentObject(viewModel)
                    .environmentObject(favoriteViewModel)
            } else {
                HomeMoviesScreenEmptyPage()
            }
        case .failed(let error):
            Text("\(error.localizedDescription)")
        }
    }
}

struct HomeMoviesScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeMoviesScreen()
    }
}
