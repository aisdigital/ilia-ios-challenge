//
//  HomeMoviesScreenLoadingPage.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 05/04/22.
//

import SwiftUI

struct HomeMoviesScreenLoadingPage: View {
    var body: some View {
        /*
         @CHANGE
         the following code has been changed to fix the layout
         */
        VStack {
            Text("Carregando...")
                .font(IICUIKit.bodyFont())
            ProgressView()
                .tint(.white)
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct HomeMoviesScreenLoadingPage_Previews: PreviewProvider {
    static var previews: some View {
        HomeMoviesScreenLoadingPage()
    }
}
