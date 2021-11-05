//
//  DetailsView.swift
//  now-playing-movies
//
//  Created by iris on 04/11/21.
//

import SwiftUI

struct DetailsView: View {
    
    private let movie: Movie
    init(movie: Movie){
        self.movie = movie
    }
    
    var body: some View {
        VStack {
            Text(movie.title)
                .font(.title)
                .lineLimit(-1)
            
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdrop_path)")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ZStack{
                    Color.gray.opacity(0.1)
                    Image(systemName: "photo")
                        .foregroundColor(Color.gray.opacity(0.5))
                        .font(.system(size: 80))
                }
            }
            .cornerRadius(20)
            .frame(width: 380, height: 230)
            
            
            HStack {
                Text("Rating:")
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow)
                    .font(.system(size: 15))
                    .padding(.trailing, -5.0)
                Text(String(movie.vote_average))
                
                Spacer()
            }.padding(20)
            
            Text(movie.overview)
                .font(.callout)
                .multilineTextAlignment(.leading)
                .padding([.leading, .bottom, .trailing], 20)
            
            Spacer()
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(movie: Movie(backdrop_path: "/eeijXm3553xvuFbkPFkDG6CLCbQ.jpg", overview: "Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, must travel to the most dangerous planet in the universe to ensure the future of his family and his people. As malevolent forces explode into conflict over the planet's exclusive supply of the most precious resource in existence-a commodity capable of unlocking humanity's greatest potential-only those who can conquer their fear will survive.", release_date: "2021-09-30", id: 0, title: "Dune", vote_average: 8.2))
    }
}
