//
//  MovieDetailView.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import SwiftUI

/// Detalhe do filme
struct MovieDetailView: View {
    // MARK: - Properties

    /// Modo para fazer dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    /// Filme
    var movie: Movie

    @State var isPresentCover: Bool = false

    // MARK: - View

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(spacing: 31) {
                    if let poster = self.movie.backdrop_path {
                        AsyncImage(url: URL(string: "\(AppConstants.imageURL)\(poster)"), scale: 1.0) { imagePhase in
                            switch imagePhase {
                            case .empty:
                                ProgressView()
                                    .frame(width: geo.size.width, height: 244)
                            case .success(let image):
                                Button {
                                    self.isPresentCover.toggle()
                                } label: {
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: geo.size.width, height: 244)
                                        .clipped()
                                        .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                                }
                                .sheet(isPresented: self.$isPresentCover) {
                                    image.resizable()
                                            .scaledToFill()
                                }

                            case .failure(_):
                                EmptyView()
                                    .frame(width: geo.size.width, height: 5)
                                    .background(Color.white)
                            @unknown default:
                                EmptyView()
                                    .frame(width: geo.size.width, height: 5)
                                    .background(Color.white)
                            }
                        }
                    }

                    Text("\t\(self.movie.overview)")
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.gilroyRegular24)
                        .foregroundColor(.neutral2)
                        .padding(.horizontal, 24.0)
                        .accessibilityIdentifier("movieDescription")
                }
            }
            .background(Color.white)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                }
            }

            ToolbarItem(placement: .principal) {
                VStack {
                    Text(self.movie.title)
                        .font(.gilroyBold24)
                        .foregroundColor(.white)

                    Text("\(self.movie.release_date) • ★\(self.movie.formatVoteAverage())(\(self.movie.movieVoteCountInThousand()))")
                        .font(.gilroyRegular16)
                        .foregroundColor(.white)
                }
            }
        }
        .navigationBarColor(UIColor(Color.primary))
    }
}

/// Preview do detalhe do filme
struct MovieDetailView_Previews: PreviewProvider {
    // MARK: - View

    static var previews: some View {
        MovieDetailView(movie: Movie(poster_path: "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg", adult: false, overview: "When an unexpected enemy emerges and threatens global safety and security, Nick Fury, director of the international peacekeeping agency known as S.H.I.E.L.D., finds himself in need of a team to pull the world back from the brink of disaster. Spanning the globe, a daring recruitment effort begins!", release_date: "2012-04-25", genre_ids: [878, 28, 12], id: 24428, original_title: "The Avengers", original_language: "en", title: "The Avengers", backdrop_path: "/hbn46fQaRmlpBuUrEiFqv0GDL6Y.jpg", popularity: 7.353212, vote_count: 8503, video: false, vote_average: 7.33))
    }
}
