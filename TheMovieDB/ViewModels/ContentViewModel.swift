//
//  ContentViewModel.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import SwiftUI
import Combine
import Security

/// View model que trata conteúdo digital
class ContentViewModel: ObservableObject {
    // MARK: - Properties

    /// Se tá carregando na tela de inicio
    @Published var isLoading: Bool = false
    /// Se vai ser mostrado um erro na tela
    @Published var showError: Bool = false
    /// Descrição do erro se é mostrado
    @Published var errorDescription: String = ""
    /// Texto de busca
    @Published var searchText: String = "" {
        didSet {
            self.searchMovies()
        }
    }
    /// Os filmes resultantes
    @Published var movies: [Movie] = []

    private var cancellables = [AnyCancellable]()
    /// Cliente do API de network
    let apiClient = APIClient(baseURL: AppConstants.baseURL)

    // MARK: - Methods

    /// Realiza a requisição para procurar filmes com o valor da busca
    func searchMovies() {
        guard !self.searchText.isEmpty else {
            self.movies = []
            return
        }

        self.isLoading = true

        self.apiClient.dispatch(SearchMoviesRequest(searchText: self.searchText))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    debugPrint("ContentViewModel.searchMovies: OK")
                case .failure(let error):
                    self.showError = true
                    self.errorDescription = "\(error)"
                }
            }, receiveValue: { value in
                debugPrint("ContentViewModel.searchMovies: movies.count=\(value.results.count), total_results=\(value.total_results), page=\(value.page)/\(value.total_pages)")
                self.movies = value.results
            })
            .store(in: &self.cancellables)
    }

    /// Usado para saber se vai mostrar a tela de filmes não achados
    /// - Returns: True se não foi achada nenhum filme
    func showNotFoundView() -> Bool {
        return !self.searchText.isEmpty && self.movies.isEmpty && !self.isLoading
    }
}
