//
//  RoundedCorner.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import SwiftUI
import Foundation

/// Criado para fazer redondos os cantos das views
struct RoundedCorner: Shape {
    // MARK: - Properties

    /// Radio desejado
    var radius: CGFloat = .infinity
    /// Canto a ser modificado
    var corners: UIRectCorner = .allCorners

    // MARK: - Shape

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: self.corners, cornerRadii: CGSize(width: self.radius, height: self.radius))
        return Path(path.cgPath)
    }
}
