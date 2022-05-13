//
//  FavoriteMoviesComponentListItem.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 07/04/22.
//

import SwiftUI

struct FavoriteMoviesComponentListItem: View {
    let height: CGFloat = 100
    let imagePath: String
    let title: String
    let releaseDate: String
    
    var body: some View {
        HStack() {
            Image("").imageMovie(path: "\(imagePath)", height: 100, width: 50)
            .padding(.leading, 15)
            VStack(alignment: .leading) {
                Text(title)
                .font(IICUIKit.bodyFontBold())
                Text(releaseDate)
                    .font(IICUIKit.bodyFont())
                
            }
        }
        .frame(maxWidth: .infinity, idealHeight: height)
    }
}

struct FavoriteMoviesComponentListItem_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesComponentListItem(imagePath: "", title: "", releaseDate: "")
    }
}
