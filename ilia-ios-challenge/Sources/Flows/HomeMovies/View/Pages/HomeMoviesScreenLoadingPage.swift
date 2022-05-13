//
//  HomeMoviesScreenLoadingPage.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 05/04/22.
//

import SwiftUI

struct HomeMoviesScreenLoadingPage: View {
    var body: some View {
        VStack {
            Text("Carregando...")
            ProgressView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct HomeMoviesScreenLoadingPage_Previews: PreviewProvider {
    static var previews: some View {
        HomeMoviesScreenLoadingPage()
    }
}
