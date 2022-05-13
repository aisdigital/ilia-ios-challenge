//
//  Modifier+TabBar.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 11/04/22.
//

import SwiftUI

struct TabBarModifier: ViewModifier {
    var selectedItemColor: Color
    
    init(backgroundColor: UIColor, selectedItemColor: UIColor, unselectedItemColor: UIColor) {
        self.selectedItemColor = Color(uiColor: selectedItemColor)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().unselectedItemTintColor = unselectedItemColor
    }
    
    func body(content: Content) -> some View {
        content
            .accentColor(selectedItemColor)
    }
}


