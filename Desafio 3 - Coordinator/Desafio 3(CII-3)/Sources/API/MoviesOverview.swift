import Foundation

class MoviesOverview: Codable {
    let dates: Dates
    let page: Int
    let results: [MovieResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    init(dates: Dates, page: Int, results: [MovieResult], totalPages: Int, totalResults: Int) {
        self.dates = dates
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
