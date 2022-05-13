//
//  Extension+View.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 04/04/22.
//

import SwiftUI

extension View {
    func navigationBarColor(backgroundColor: Color, titleColor: Color?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: UIColor(titleColor ?? Color.clear)))
    }
    
    func imageMovie(path: String, height: CGFloat, width: CGFloat) -> some View {
        self.modifier(ImageModifier(path: path, height: height, width: width))
    }
    
    func colorFromValue(value: Double) -> some View {
        self.modifier(TextColorModifier(value: value))
    }
    
    func tabBarColor(backgroundColor: Color, selectedItemColor: Color, unselectedItemColor: Color) -> some View {
        self.modifier(TabBarModifier(backgroundColor: UIColor(backgroundColor), selectedItemColor: UIColor(selectedItemColor), unselectedItemColor: UIColor(unselectedItemColor)))
    }
}
