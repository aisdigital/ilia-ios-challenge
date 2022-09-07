//
//  HomeMoviesScreen.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import SwiftUI

/*
 @DELETION
 The following view has been deleted because we created a common empty view to reuse in other pages
 struct HomeMoviesScreenEmptyPage: View
 */

struct HomeMoviesScreen: View {
    @EnvironmentObject private var viewModel: HomeMoviesViewModel
    @EnvironmentObject private var favoriteViewModel: FavoriteMoviesViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            /*
             @CHANGE
             this code has been changed to adapt to the new reusable empty page
             */
            EmptyPage(title: viewModel.emptyTitle)
                .onAppear {
                    /*
                     @INSERTION
                     A task was inserted to manage the asynchronous function call, as the onAppear method does not support using asynchronous functions
                     */
                    Task {
                        await self.viewModel.loadMovies()
                    }
                }
        case .loading:
            HomeMoviesScreenLoadingPage()
        /*
         @CHANGE
         added the new state to switch
         */
        case .loaded, .loadingNextPage:
            if viewModel.hasMovies() {
                HomeMoviesScreenMainPage()
                    .environmentObject(viewModel)
                    .environmentObject(favoriteViewModel)
            } else {
                /*
                 @CHANGE
                 this code has been changed to adapt to the new reusable empty page
                 */
                EmptyPage(title: viewModel.emptyTitle)
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
