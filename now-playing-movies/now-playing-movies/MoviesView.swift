//
//  MoviesView.swift
//  now-playing-movies
//
//  Created by iris on 04/11/21.
//

import SwiftUI

struct MoviesView: View {
    @StateObject var movies = MoviesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(movies.movie) { movie in
                    
                    NavigationLink(destination: DetailsView(movie: Movie(backdrop_path: movie.backdrop_path,
                                                                         overview: movie.overview,
                                                                         release_date: movie.release_date,
                                                                         id: movie.id,
                                                                         title: movie.title,
                                                                         vote_average: movie.vote_average))) {
                        MovieView(movie: Movie(backdrop_path: movie.backdrop_path,
                                               overview: movie.overview,
                                               release_date: movie.release_date,
                                               id: movie.id,
                                               title: movie.title,
                                               vote_average: movie.vote_average))
                    }
                    
//                    NavigationButton(destination: ShowView(feedResult: feedRow)) {
//                        FeedRowView(feedResult: feedRow)
//                    }
                }
            }.navigationBarTitle(Text("In Theaters"))
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
