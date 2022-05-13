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
        NavigationView {
            ScrollView {
                ForEach(viewModel.favoriteMovies.indices, id: \.self) { movieIndex in
                    let mv = viewModel.favoriteMovies[movieIndex]
                    let destinationView = HomeMoviesScreenDetailPage(movie: mv, isFavorite: true)
                        .background(IICUIKit.backGroundColor)
                        .environmentObject(viewModel)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Favorite Movies")
                        .navigationBarColor(backgroundColor: IICUIKit.navigationBarColor, titleColor: IICUIKit.secondaryColor)
                    
                    NavigationLink(destination: destinationView) {
                        FavoriteMoviesComponentListItem(imagePath: mv.posterPath ?? "", title: mv.title ?? "", releaseDate: mv.releaseDate ?? "")
                            .background(.green)
                    }
                    .padding(.top, 6)
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .background(IICUIKit.backGroundColor)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Favorite Movies")
            .navigationBarColor(backgroundColor: IICUIKit.navigationBarColor, titleColor: IICUIKit.secondaryColor)
        }
    }
}

struct FavoriteMoviesPageComponentList_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesPageComponentList()
    }
}
