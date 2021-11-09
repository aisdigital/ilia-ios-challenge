//
//  MovieCellView.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import SwiftUI

/// Celda de um filme
struct MovieCellView: View {
    // MARK: - Properties

    /// Filme
    var movie: Movie

    // MARK: - View

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                Rectangle()
                    .frame(width: 152, height: 32, alignment: .center)
                    .foregroundColor(.white)

                Rectangle()
                    .fill(LinearGradient(colors: AppConstants.backgroundCellColors, startPoint: .leading, endPoint: .trailing))
                    .frame(width: 152, height: 74, alignment: .center)
                    .cornerRadius(15, corners: [.topLeft, .topRight])

                ZStack {
                    Rectangle()
                        .fill(.white)
                        .frame(width: 152, height: 33, alignment: .center)
                        .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                        .shadow(color: .neutral, radius: 3)

                    Text(self.movie.title)
                        .font(.gilroySemiBold14)
                        .minimumScaleFactor(0.05)
                        .foregroundColor(.neutral2)
                        .frame(width: 152, height: 33, alignment: .center)
                }
            }

            if let poster = self.movie.poster_path {
                AsyncImage(url: URL(string: "\(AppConstants.imageURL)\(poster)"), scale: 1.0) { imagePhase in
                    switch imagePhase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 88, height: 106, alignment: .center)
                            .clipped()
                            .cornerRadius(15, corners: [.topLeft, .topRight])
                    case .failure(let err):
                        Text("Não foi possível carregar a imagem\n\(err.localizedDescription)")
                            .font(.gilroyRegular14)
                            .foregroundColor(.statusError)
                            .lineLimit(4)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            else {
                Text("Não foi possível carregar a imagem")
                    .font(.gilroyRegular14)
                    .foregroundColor(.statusError)
                    .lineLimit(4)
            }
        }
    }
}

/// Preview da celda de um filme
struct MovieCellView_Previews: PreviewProvider {
    // MARK: - View

    static var previews: some View {
        MovieCellView(movie: Movie(poster_path: "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg", adult: false, overview: "When an unexpected enemy emerges and threatens global safety and security, Nick Fury, director of the international peacekeeping agency known as S.H.I.E.L.D., finds himself in need of a team to pull the world back from the brink of disaster. Spanning the globe, a daring recruitment effort begins!", release_date: "2012-04-25", genre_ids: [878, 28, 12], id: 24428, original_title: "The Avengers", original_language: "en", title: "The Avengers", backdrop_path: "/hbn46fQaRmlpBuUrEiFqv0GDL6Y.jpg", popularity: 7.353212, vote_count: 8503, video: false, vote_average: 7.33))
    }
}
