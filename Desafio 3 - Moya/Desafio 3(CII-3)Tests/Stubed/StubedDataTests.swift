//
//  StubedDataTests.swift
//  Desafio 3(CII-3)Tests
//
//  Created by Guilherme Daniel Fernandes da Silva on 02/12/21.
//

import XCTest
import Moya
@testable import Desafio_3_CII_3_

class StubedDataTests: XCTestCase {
    let provider = MoyaProvider<MovieAPI>.init(stubClosure: MoyaProvider<MovieAPI>.immediatelyStub)
    
    // Test if the value of the data is not null
    func testIfStubedDataIsNotNil() {
        provider.request(.upcomingMovies(page: 1)) { (result) in
            switch result {
            case .success(let response):
                let user = try? JSONDecoder().decode(MoviesOverview.self, from: response.data)
                XCTAssertNotNil(user?.results)
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Test if the number of results is correct
    func testIfDataSizeIsEqualTheExpected() {
        provider.request(.upcomingMovies(page: 1)) { (result) in
            switch result {
            case .success(let response):
                let user = try? JSONDecoder().decode(MoviesOverview.self, from: response.data)
                XCTAssertEqual(user?.results.count, 20)
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}

