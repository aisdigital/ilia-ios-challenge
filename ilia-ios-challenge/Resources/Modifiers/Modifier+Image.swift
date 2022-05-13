//
//  Modifier+Image.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 10/04/22.
//

import SwiftUI

struct ImageModifier: ViewModifier {
    
    var path: String
    var height: CGFloat
    var width: CGFloat
    let imageAPI = ImageAPI()
    
    
    init(path: String, height: CGFloat, width: CGFloat) {
        self.path = path
        self.height = height
        self.width = width
    }
    
    func body(content: Content) -> some View {
        AsyncImage(url: URL(string: "\(imageAPI.baseURL)\(path)")) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(maxWidth: self.width, maxHeight: self.height)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .frame(maxWidth: self.width, maxHeight: self.height)
            case .failure:
                Image(systemName: "cloud")
            @unknown default:
                EmptyView()
            }
        }
    }
}
