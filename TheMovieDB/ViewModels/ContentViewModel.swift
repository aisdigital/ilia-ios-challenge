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
    /// O ID do youtube para ser mostrado
    @Published var youtubeID: String = ""
    /// Se é possível carregar mais páginas
    @Published var isPosibleLoadMore: Bool = false

    private var cancellables = [AnyCancellable]()
    private var cancellablesTrailer = [AnyCancellable]()
    
    /// Cliente do API de network
    let apiClient = APIClient(baseURL: AppConstants.baseURL)

    /// Atual página
    var currentPage: Int = 1
    /// Total de páginas
    var totalPages: Int = 1

    // MARK: - Methods

    /// Realiza a requisição para procurar filmes com o valor da busca
    func searchMovies() {
        guard !self.searchText.isEmpty else {
            self.movies = []
            return
        }

        self.isPosibleLoadMore = false
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
                self.currentPage = value.page
                self.totalPages = value.total_pages

                self.isPosibleLoadMore = self.currentPage < self.totalPages
            })
            .store(in: &self.cancellables)
    }

    /// Carrega mais filmes
    func loadMore() {
        self.currentPage += 1

        self.isPosibleLoadMore = self.currentPage < self.totalPages

        self.apiClient.dispatch(SearchMoviesRequest(searchText: self.searchText , page: self.currentPage))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    debugPrint("ContentViewModel.loadMore: OK")
                case .failure(let error):
                    self.showError = true
                    self.errorDescription = "\(error)"
                }
            }, receiveValue: { value in
                debugPrint("ContentViewModel.loadMore: movies.count=\(value.results.count), total_results=\(value.total_results), page=\(value.page)/\(value.total_pages)")
                self.movies = self.movies + value.results
                self.currentPage = value.page
                self.totalPages = value.total_pages

                self.isPosibleLoadMore = self.currentPage < self.totalPages
            })
            .store(in: &self.cancellables)
    }

    /// Requisita o trailer do filme
    /// - Parameter movie: O filme
    func requetTrailer(movie: Movie) {
        self.youtubeID = ""

        self.apiClient.dispatch(TrailerRequest(movieID: movie.id))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    debugPrint("ContentViewModel.getTrailer: OK")
                case .failure(let error):
                    self.youtubeID = ""
                    debugPrint("ContentViewModel.getTrailer: Error=\(error)")
                }
            }, receiveValue: { value in
                debugPrint("ContentViewModel.getTrailer: trailer.count=\(value.results.count)")

                let trailers = value.results.filter { trailer in
                    trailer.site.capitalized == "YouTube".capitalized
                }

                if let key = trailers.first?.key {
                    self.youtubeID = key
                }
                else {
                    self.youtubeID = ""
                }
            })
            .store(in: &self.cancellablesTrailer)
    }

    /// Usado para saber se vai mostrar a tela de filmes não achados
    /// - Returns: True se não foi achada nenhum filme
    func showNotFoundView() -> Bool {
        return !self.searchText.isEmpty && self.movies.isEmpty && !self.isLoading
    }
}
