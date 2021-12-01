import Foundation

class Movie: Codable {
    let dates: Dates
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    init(dates: Dates, page: Int, results: [Result], totalPages: Int, totalResults: Int) {
        self.dates = dates
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
