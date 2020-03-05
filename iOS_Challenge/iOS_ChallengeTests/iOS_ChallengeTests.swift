//
//  iOS_ChallengeTests.swift
//  iOS_ChallengeTests
//
//  Created by Gabriel Messias on 04/03/20.
//  Copyright © 2020 Gabriel Messias. All rights reserved.
//

import XCTest
@testable import TheMovies

class iOS_ChallengeTests: XCTestCase {

    var film: Film!
    var image: UIImage!
    
    override func setUp() {
        self.film = Film(name: "Nome", description: "Descricao", releaseDate: "2020", imagePath: "")
        self.image = UIImage()
    }

    override func tearDown() {
        
    }
    
    func testTheMovieServiceAPIMovies(){
        let theMoviesAPI = TheMovieServiceAPI()
        let filmsViewModel = FilmsTableViewModel()
        
        theMoviesAPI.imageDelegate = filmsViewModel
        theMoviesAPI.dataDelegate = filmsViewModel
        
        theMoviesAPI.fetchMovies(page: 1)
        
        XCTAssertEqual(filmsViewModel.films.count, 0)
        
    }
    
    func testDetailViewModel(){
        
        let detailVM = DetailViewModel(film: film, image: image)
        
        XCTAssertEqual(detailVM.name, film.name)
        XCTAssertEqual(detailVM.overview, film.description)
        XCTAssertEqual(detailVM.releaseYear, film.releaseDate)
    }
    
    func testDetailViewController(){
        let detailVC = DetailViewController()
        let detailVM = DetailViewModel(film: self.film, image: self.image)
        
        XCTAssertNotEqual(detailVC.detailViewModel?.name, detailVM.name)
        XCTAssertNotEqual(detailVC.detailViewModel?.overview, detailVM.overview)
        XCTAssertNotEqual(detailVC.detailViewModel?.releaseYear, detailVM.releaseYear)
        
        detailVC.detailViewModel = detailVM
        
        XCTAssertEqual(detailVC.detailViewModel?.name, detailVM.name)
        XCTAssertEqual(detailVC.detailViewModel?.overview, detailVM.overview)
        XCTAssertEqual(detailVC.detailViewModel?.releaseYear, detailVM.releaseYear)
    }

}
