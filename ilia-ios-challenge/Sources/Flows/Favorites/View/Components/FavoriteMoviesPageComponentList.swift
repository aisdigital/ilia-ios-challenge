//
//  FavoriteMoviesPageComponentList.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 07/04/22.
//

import SwiftUI

struct FavoriteMoviesPageComponentList: View {
    @EnvironmentObject private var viewModel: FavoriteMoviesViewModel
    
    var body: some View {
        /*
         @CHANGE
         removed navigation view because we dont need it anymore, because the navigation view is on IICTabBarScreen
         */
        ScrollView {
            ForEach(viewModel.favoriteMovies.indices, id: \.self) { movieIndex in
                let mv = viewModel.favoriteMovies[movieIndex]
                let destinationView = HomeMoviesScreenDetailPage(movie: mv, isFavorite: true)
                    .background(IICUIKit.backGroundColor)
                    .environmentObject(viewModel)
                    /*
                     @DELETION
                     removed the navigation bar modifiers because it has already been added in the IICTabBarScreen
                     */
                
                NavigationLink(destination: destinationView) {
                    FavoriteMoviesComponentListItem(imagePath: mv.posterPath ?? "", title: mv.title ?? "", releaseDate: mv.releaseDate ?? "")
                        /*
                         @CHANGE
                         fixing the background color of each cell
                         */
                        .background(IICUIKit.listItemColor)
                }
                .padding(.top, 6)
                .buttonStyle(PlainButtonStyle())
            }
        }
        /*
         @INSERTION
         add this method to update the favorites movies every time view appear
         */
        .onAppear(perform: {
            viewModel.loadFavoriteMovies()
        })
        .background(IICUIKit.backGroundColor)
    }
}

struct FavoriteMoviesPageComponentList_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesPageComponentList()
    }
}
