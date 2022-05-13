//
//  IICUIKit.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import SwiftUI


protocol IICUIKitProtocol {
    static var primaryColor: Color { get }
}

class IICUIKit : IICUIKitProtocol {
    static var primaryColor = Color(hexLightMode: "#4A6572", hexDarkMode: "#4A6572")
    static var secondaryColor = Color(hexLightMode: "#F9AA33", hexDarkMode: "#F9AA33")
    static var navigationBarColor = Color(hexLightMode: "#232F34", hexDarkMode: "#232F34")
    static var backGroundColor = Color(hexLightMode: "#344955", hexDarkMode: "#344955")
    static var listItemColor = Color(hexLightMode: "#4A6572", hexDarkMode: "#4A6572")
    static var textColor = Color(hexLightMode: "#DCDCDC", hexDarkMode: "#DCDCDC")
}

extension IICUIKit {
    
    static func regularFont(size: CGFloat) -> Font {
        return Font(UIFont(name: "Courier", size: size) ?? UIFont.systemFont(ofSize: size))
    }
    
    static func regularFontBold(size: CGFloat) -> Font {
        return Font(UIFont(name: "Courier-Bold", size: size) ?? UIFont.systemFont(ofSize: size))
    }
    
    static func bodyFont() -> Font {
        return regularFont(size: 16)
    }
    
    static func bodyFontBold() -> Font {
        return regularFontBold(size: 16)
    }
    
    static func titleFontBold() -> Font {
        return regularFontBold(size: 22)
    }
    
    static func posterTitleFontBold() -> Font {
        return regularFontBold(size: 18)
    }

    
}

