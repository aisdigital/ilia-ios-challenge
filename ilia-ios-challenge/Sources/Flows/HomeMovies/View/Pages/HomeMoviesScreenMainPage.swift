//
//  HomeMoviesScreenMainPage.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import SwiftUI

struct HomeMoviesScreenMainPage: View {
    @EnvironmentObject private var viewModel: HomeMoviesViewModel
    @EnvironmentObject private var favoriteViewModel: FavoriteMoviesViewModel
    
    var body: some View {
        HomeMoviesPageComponentList()
            .environmentObject(viewModel)
    }
}

struct HomeMoviesScreenPage_Previews: PreviewProvider {
    static var previews: some View {
        HomeMoviesScreenMainPage()
    }
}
