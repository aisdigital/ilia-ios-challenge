//
//  MovieView.swift
//  now-playing-movies
//
//  Created by iris on 04/11/21.
//

import SwiftUI

struct MovieView: View {
    private let movie: Movie
    init(movie: Movie){
        self.movie = movie
    }
    
    var body: some View {
        HStack {
            Text(movie.title)
                .font(.footnote)
                .lineLimit(1)
            Spacer()
            Text(String(movie.vote_average))
                .font(.footnote)
            
            Image(systemName: "star.fill")
                .foregroundColor(Color.yellow)
                .font(.system(size: 11))
                .padding(.leading, -5.0)
        }.padding()
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: Movie(backdrop_path: "", overview: "", release_date: "", id: 0, title: "Spirited Away", vote_average: 8.6))
    }
}
