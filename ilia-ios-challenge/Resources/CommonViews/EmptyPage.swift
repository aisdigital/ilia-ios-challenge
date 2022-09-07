//
//  EmptyPage.swift
//  ilia-ios-challenge
//
//  Created by Antonio Carlos on 06/09/22.
//

import SwiftUI

/*
 @INSERTION
 This view has been created because we use the empty state in two different pages
 */
struct EmptyPage: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(IICUIKit.bodyFontBold())
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Empty_Page_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPage(title: "Tela vazia")
    }
}
