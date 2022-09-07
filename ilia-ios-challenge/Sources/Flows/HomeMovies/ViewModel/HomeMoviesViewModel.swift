//
//  HomeMoviesViewModel.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import Foundation
import SwiftUI

class HomeMoviesViewModel: ObservableObject {
    var moviesRepository: MoviesRepositoryProtocol
    
    private(set) var movies: [MovieResponse] = []
    /*
     @INSERTION
     this property was inserted to handle pagination
     */
    private var page = 1
    private var pageLimit = 1000
    
    /*
     @INSERTION
     This property has been added to viewModel in order to configure the empty title of the view
     */
    var emptyTitle: String {
        "Não há filmes"
    }
    
    /*
     @CHANGE
     This variable needs to be Published instead of State, because the class is an ObservableObject and not a view
     */
    @Published private(set) var state = LoadingState.idle
    
    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }
    
    /*
     @INSERTION
     The @MainActor keyword was inserted so that the function runs on the Main Thread and there are no problems in updating the UI
     */
    @MainActor func loadMovies() async {
        /*
         @CHANGE
         changing the state logic to handle pagination
         */
        self.state = page > 1 ? .loadingNextPage : .loaded
        do {
            /*
             @CHANGE
             fix logic to append the movies loaded
             */
            let response = try await moviesRepository.getUpcomingMovies(page: page)
            
            pageLimit = response.totalPages
            self.movies.append(contentsOf: response.results)
            self.state = .loaded
        } catch let error {
            self.movies = []
            self.state = .failed(error)
        }
    }
    
    /*
     @INSERTION
     this function has been created to handle pagination
     */
    func loadMoreMovies(itemIndex: Int) async {
        guard page < pageLimit else { return }
        
        guard state == .loaded else { return }
        
        guard itemIndex == movies.endIndex-1 else { return }
        
        page += 1
        await loadMovies()
    }
    
    func hasMovies() -> Bool {
        /*
         @CHANGE
         Made the change because the isEmpty variable returns true if it is empty, so if it has objects it returns false, so we have to deny it.
         I also removed the return because it is not necessary when there is only one line in the function
         */
        !movies.isEmpty
    }
}
