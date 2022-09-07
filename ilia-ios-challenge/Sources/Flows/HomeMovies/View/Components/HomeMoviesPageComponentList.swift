//
//  HomeMoviesPageComponentList.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import SwiftUI

struct HomeMoviesPageComponentList: View {
    @EnvironmentObject private var viewModel: HomeMoviesViewModel
    @EnvironmentObject private var favoriteViewModel: FavoriteMoviesViewModel
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120)),
    ]
    
    let height: CGFloat = 250
    
    var body: some View {
        /*
         @CHANGE
         removed navigation view and it´s modifiers because it's done on IICTabBarScreen
         */
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.movies.indices, id: \.self) { movieIndex in
                    let mv = viewModel.movies[movieIndex]
                    let isFavorite = favoriteViewModel.isFavoriteMovie(movie: mv)
                    let destinationView = HomeMoviesScreenDetailPage(movie: mv, isFavorite: isFavorite)
                        .background(IICUIKit.backGroundColor)
                        .environmentObject(favoriteViewModel)
                    
                    NavigationLink(destination: destinationView) {
                        HomeMoviesComponentListItem(title: mv.title!, posterPath: mv.posterPath)
                            .frame(height: height)
                    }
                    .onAppear(perform: {
                        Task { [movieIndex] in
                            await viewModel.loadMoreMovies(itemIndex: movieIndex)
                        }
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
            /*
             @INSERTION
             added this code to handle when is loading next page
             */
            if viewModel.state == .loadingNextPage {
                ProgressView()
                    .tint(.white)
            }
        }
        .background(IICUIKit.backGroundColor)
    }
}

struct HomeMoviesPageComponentList_Previews: PreviewProvider {
    static var previews: some View {
        HomeMoviesPageComponentList()
    }
}
