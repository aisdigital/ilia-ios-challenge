//
//  HomeMoviesScreenDetailPage.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import SwiftUI

struct HomeMoviesScreenDetailPage: View {
    @EnvironmentObject private var favoriteViewModel: FavoriteMoviesViewModel
    
    var movie: MovieResponse
    @State var isFavorite: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .center) {
                Image("").imageMovie(path: "\(movie.posterPath ?? "")", height: 250, width: 150)
                .padding(.top, 10)
                
                Text(movie.title ?? "")
                    .font(IICUIKit.titleFontBold())
                    .padding(20)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Text("Release date: ")
                        .font(IICUIKit.bodyFontBold())
                    Text(movie.releaseDate?.toFormattedDate()?.toFormattedString() ?? "")
                        .font(IICUIKit.bodyFont())
                }
                HStack(spacing: 0) {
                    Text("Vote average: ")
                        .font(IICUIKit.bodyFontBold())
                    Text(String(movie.voteAverage ?? 0))
                        .font(IICUIKit.bodyFont())
                }
            }
            .padding(.leading)
            .padding(.bottom)
            
            ScrollView {
                Text(movie.overview ?? "")
                    .font(IICUIKit.bodyFont())
                    .padding(.horizontal)
            }
        }
        .onAppear(perform: {
            isFavorite = false
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Movie Detail")
        .navigationBarColor(backgroundColor: IICUIKit.navigationBarColor, titleColor: IICUIKit.secondaryColor)
        .navigationBarItems(trailing:
            Button(action: {
            if isFavorite {
                    favoriteViewModel.deleteFavoriteMovie(movie: movie)
                } else {
                    favoriteViewModel.deleteFavoriteMovie(movie: movie)
                }
                favoriteViewModel.loadFavoriteMovies()
                isFavorite.toggle()
            }) {
                Image(systemName: isFavorite ?  "heart.fill" : "heart").imageScale(.large).foregroundColor(.red)
            }
        )
    }
    
}

struct HomeMoviesScreenDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        Text("HomeMoviesScreenDetailPage")
    }
}
