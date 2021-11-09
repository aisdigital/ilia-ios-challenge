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
                    Text("Sem resultado")
                }
                else {
                    ScrollView {
                        LazyVGrid(columns: self.columns, spacing: 16) {
                            ForEach(self.viewModel.movies) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    MovieCellView(movie: movie)
                                }
                            }
                        }
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
        .toast(isPresenting: self.$viewModel.showError, duration: 2, tapToDismiss: true) {
            AlertToast(displayMode: .hud, type: .error(.red), title: "Erro", subTitle: self.viewModel.errorDescription)
        }
    }
}

/// Preview da tela inicial
struct HomeView_Previews: PreviewProvider {
    // MARK: - View

    static var previews: some View {
        HomeView()
    }
}
