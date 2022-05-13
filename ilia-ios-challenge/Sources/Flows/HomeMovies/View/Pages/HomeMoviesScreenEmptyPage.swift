//
//  HomeMoviesScreenEmptyPage.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import SwiftUI

struct HomeMoviesScreenEmptyPage: View {
    var body: some View {
        Text("Não há filmes")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct HomeMoviesScreenEmptyPage_Previews: PreviewProvider {
    static var previews: some View {
        HomeMoviesScreenEmptyPage()
    }
}
