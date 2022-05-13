//
//  HomeMoviesComponentListItem.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import SwiftUI

struct HomeMoviesComponentListItem: View {
    let title: String
    let posterPath: String?
    var path: String {
        return posterPath ?? ""
    }
    
    var body: some View {
        VStack {
            Image("").imageMovie(path: "\(path)", height: 250, width: 150)
            Text(title)
                .foregroundColor(IICUIKit.textColor)
                .font(IICUIKit.posterTitleFontBold())
                .lineLimit(3)
            
        }
    }
}

struct HomeMoviesComponentListItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeMoviesComponentListItem(title: "", posterPath: "")
    }
}
