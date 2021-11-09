//
//  SecuritySettings.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import SwiftUI
import Combine
import Security

/// Variaveis de segurança
class SecuritySettings: ObservableObject {
    // MARK: - Properties

    /// Se o usuário foi carregado
    @Published var isUserLoaded: Bool = false

    /// Crrega as variáveis do keychain se tem
    init() {
        if let username = UserDefaults.standard.object(forKey: "username") as? String {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: username,
                kSecMatchLimit as String: kSecMatchLimitOne,
                kSecReturnAttributes as String: true,
                kSecReturnData as String: true,
            ]

            var item: CFTypeRef?

            if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
                if let existingItem = item as? [String: Any],
                   let _ = existingItem[kSecAttrAccount as String] as? String,
                   let passwordData = existingItem[kSecValueData as String] as? Data,
                   let _ = String(data: passwordData, encoding: .utf8) {
                    self.isUserLoaded = true
                }
            }
        }
    }

    /// Relaiza logout. Para isso deleta as variáveis de keychain e de usuário
    func logout() {
        if let username = UserDefaults.standard.object(forKey: "username") as? String {
            UserDefaults.standard.removeObject(forKey: "username")
            UserDefaults.standard.removeObject(forKey: "guest_session_id")
            UserDefaults.standard.removeObject(forKey: "request_token")

            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: username,
            ]

            if SecItemDelete(query as CFDictionary) == noErr {
                self.isUserLoaded = false
            }
        }
    }
}
