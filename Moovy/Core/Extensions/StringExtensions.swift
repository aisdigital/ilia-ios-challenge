//
//  StringExtensions.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 01/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

struct StringConstants {
    static let movies = NSLocalizedString("Movies", comment: "")
    static let movieSearchBarPlaceholder = NSLocalizedString("MovieSearchBarPlaceholder", comment: "")
    static let cast = NSLocalizedString("Cast", comment: "")
    static let crew = NSLocalizedString("Crew", comment: "")
}

struct ErrorConstants {
    static let genericErrorTitle = NSLocalizedString("Error", comment: "")
    static let genericFetchErrorMessage = NSLocalizedString("GenericFetchErrorMessage", comment: "")
    static let genericParseErrorMessage = NSLocalizedString("GenericParseErrorMessage", comment: "")
    static let noConnectionTitle = NSLocalizedString("NoConnectionTitle", comment: "")
    static let noConnectionMessage = NSLocalizedString("NoConnectionMessage", comment: "")
}
