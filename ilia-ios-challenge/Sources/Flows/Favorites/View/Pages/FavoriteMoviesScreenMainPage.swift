//
//  FavoriteMoviesScreenPage.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 07/04/22.
//

import SwiftUI

struct FavoriteMoviesScreenMainPage: View {
    @EnvironmentObject private var viewModel: FavoriteMoviesViewModel
    
    var body: some View {
        /*
         @CHANGE
         The following code has been changed to handle the empty state of this view
         */
        if viewModel.hasMovies() {
            FavoriteMoviesPageComponentList()
                .environmentObject(viewModel)
        } else {
            EmptyPage(title: viewModel.emptyTitle)
        }
    }
}

struct FavoriteMoviesScreenPage_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesScreenMainPage()
    }
}
