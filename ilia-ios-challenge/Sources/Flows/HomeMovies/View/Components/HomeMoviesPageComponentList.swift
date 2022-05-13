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
        NavigationView {
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
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .background(IICUIKit.backGroundColor)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Movies Details")
            .navigationBarColor(backgroundColor: .yellow, titleColor: .red)
        }
       
    }
}

struct HomeMoviesPageComponentList_Previews: PreviewProvider {
    static var previews: some View {
        HomeMoviesPageComponentList()
    }
}
