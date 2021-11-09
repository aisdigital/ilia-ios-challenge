//
//  AppConstants.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import Foundation
import SwiftUI

/// Constantes do App
class AppConstants {
    /// URL principal
    static let principalURL: String = "https://api.themoviedb.org/"
    /// URL base
    static let baseURL: String = "\(AppConstants.principalURL)3"
    /// API key
    static let apiKey: String = "46a6b20dea84afed45f7c594fa0728e4"

    /// Cores do gradiente de fundos da tela de login
    static var backgroundGradientColors: [Color] = [
        .black,
        Color(red: 0/255, green: 59/255, blue: 90/255),
        Color(red: 1/255, green: 110/255, blue: 150/255),
        Color(red: 0/255, green: 59/255, blue: 90/255),
        .black]
    /// Cores da celda de empresas na tela principal
    static var backgroundCellColors: [Color] = [
        Color(red: 139/255, green: 205/255, blue: 162/255),
        Color.secondary]
}
