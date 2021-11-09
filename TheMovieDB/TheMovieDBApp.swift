//
//  TheMovieDBApp.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import SwiftUI

/// Main View
@main
struct TheMovieDBApp: App {
    // MARK: - Properties

    /// Variaveis de segurança
    @StateObject var securitySettings = SecuritySettings()

    // MARK: - View

    var body: some Scene {
        WindowGroup {
            if !self.securitySettings.isUserLoaded {
                LoginView()
                    .environmentObject(self.securitySettings)
                    .preferredColorScheme(.dark)
            }
            else {
                HomeView()
                    .environmentObject(self.securitySettings)
                    .preferredColorScheme(.dark)
            }
        }
    }
}

extension View {
    // MARK: - Methods

    /// Método usado para redondear os cantos
    /// - Parameters:
    ///   - radius: Radio
    ///   - corners: O canto desejado
    /// - Returns: Retorna a mesma view modificada
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }

    /// Modificador para mudar a cor do navigation bar
    /// - Parameter backgroundColor: Cor desejada
    /// - Returns: Retorna a mesma view modificada
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
}
