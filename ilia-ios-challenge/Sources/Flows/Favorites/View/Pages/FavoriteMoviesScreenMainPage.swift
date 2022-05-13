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
        FavoriteMoviesPageComponentList().environmentObject(viewModel)
    }
}

struct FavoriteMoviesScreenPage_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesScreenMainPage()
    }
}
