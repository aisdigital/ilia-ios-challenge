//
//  HomeView.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import SwiftUI
import AlertToast

/// Tela inicial
struct HomeView: View {
    // MARK: - Properties

    /// Variaveis de segurança
    @EnvironmentObject var securitySettings: SecuritySettings
    /// View model dos conteúdos
    @StateObject var viewModel = ContentViewModel()

    /// Colunas do grid
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    // MARK: - View

    var body: some View {
        NavigationView {
            VStack {
                if self.viewModel.showNotFoundView() {
                    ZStack {
                        Rectangle()
                            .background(Color.white)
                        Text("Sem resultados")
                            .font(.robotoLight24)
                            .foregroundColor(Color.primary)

                    }
                }
                else {
                    if self.viewModel.movies.isEmpty {
                        ZStack {
                            Rectangle()
                                .background(Color.white)
                            Text("Procure por algum filme...")
                                .font(.robotoLight24)
                                .foregroundColor(Color.primary)

                        }
                    }
                    else {
                        ScrollView {
                            LazyVGrid(columns: self.columns, spacing: 16) {
                                ForEach(self.viewModel.movies) { movie in
                                    NavigationLink(destination: MovieDetailView(viewModel: self.viewModel, movie: movie)) {
                                        MovieCellView(movie: movie)
                                    }
                                }
                            }

                            if self.viewModel.isPosibleLoadMore {
                                Button {
                                    self.viewModel.loadMore()
                                } label: {
                                    Text("CARREGAR MAIS")
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.primary)
                                        .foregroundColor(.white)
                                        .clipShape(Capsule())
                                }
                                .padding(.horizontal, 24)
                                .padding(.vertical, 10)
                            }
                        }
                        .background(.white)
                    }
                }
            }
            .background(.white)
            .searchable(text: self.$viewModel.searchText, prompt: "Buscar...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.securitySettings.logout()
                    } label: {
                        Text("Logout")
                    }
                }

                ToolbarItem(placement: .principal) {
                    VStack {
                        Image("title")
                    }
                }
            }
            .navigationBarColor(UIColor(Color.primary))
        }
        .toast(isPresenting: self.$viewModel.isLoading) {
            AlertToast(type: .loading)
        }
        .background(.white)
    }
}

/// Preview da tela inicial
struct HomeView_Previews: PreviewProvider {
    // MARK: - View

    static var previews: some View {
        HomeView()
    }
}
