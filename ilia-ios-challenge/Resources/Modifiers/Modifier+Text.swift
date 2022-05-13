//
//  Modifier+Text.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 10/04/22.
//

import SwiftUI

struct TextColorModifier: ViewModifier {
    
    private var textolor: Color
   
    init(value: Double) {
        switch value {
        case 0...3.9 :
            textolor = .red
        case 4.0...5.9 :
            textolor = .yellow
        default :
            textolor = .green
        }
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(textolor)
    }
}
