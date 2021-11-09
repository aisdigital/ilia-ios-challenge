//
//  LoginViewModel.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import SwiftUI
import Combine
import Security

/// View model de login
class LoginViewModel: ObservableObject {
    // MARK: - Properties

    /// Username
    @Published var username: String = ""
    /// Senha
    @Published var password: String = ""
    /// Se tá carregando uma requisição
    @Published var isLoading: Bool = false
    /// Se vai ser mostrado um erro na tela
    @Published var showError: Bool = false
    /// Descrição do erro se é mostrado
    @Published var errorDescription: String = ""
    /// Se o login tá completado
    @Published var completedLogin: Bool = false

    private var cancellablesRequsetToken = [AnyCancellable]()
    private var cancellablesCreateSessionWithLogin = [AnyCancellable]()
    /// Cliente do API de network
    let apiClient = APIClient(baseURL: AppConstants.baseURL)

    // MARK: - Methods

    /// Método para tentar logarse
    func signIn() {
        self.isLoading = true

        self.createRequestToken()
    }

    /// Método que cria um request token para nos logar
    func createRequestToken() {
        self.apiClient.dispatch(CreateRequestToken())
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    debugPrint("LoginViewModel.createRequestToken: OK")
                case .failure(let error):
                    self.showError = true
                    self.errorDescription = "\(error)"
                    UserDefaults.standard.removeObject(forKey: "request_token")
                }
            } receiveValue: { value in
                debugPrint("LoginViewModel.createRequestToken: \(value)")

                if let success = value.success, success, let request_token = value.request_token {
                    UserDefaults.standard.set(request_token, forKey: "request_token")
                    self.createSessionWithLogin(requestToken: request_token)
                }
                else {
                    self.showError = true
                    self.errorDescription = "resposta do servidor sem sucesso"
                }
            }
            .store(in: &self.cancellablesRequsetToken)
    }

    /// Método para criar a sesão com o login
    /// - Parameter requestToken: Request token
    func createSessionWithLogin(requestToken: String) {
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: self.username,
            kSecValueData as String: self.password.data(using: .utf8) ?? self.password,
        ]

        self.apiClient.dispatch(SignInRequest(username: self.username, password: self.password, requestToken: requestToken))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    debugPrint("LoginViewModel.createSessionWithLogin: OK")
                case .failure(let error):
                    self.showError = true
                    self.errorDescription = "\(error)"
                    UserDefaults.standard.removeObject(forKey: "request_token")
                }
            }, receiveValue: { value in
                debugPrint("LoginViewModel.createSessionWithLogin: \(value)")

                if let success = value.success, success, let request_token = value.request_token, SecItemAdd(attributes as CFDictionary, nil) == noErr {
                    UserDefaults.standard.set(request_token, forKey: "request_token")
                    UserDefaults.standard.set(self.username, forKey: "username")
                    self.completedLogin = true
                }
                else {
                    self.showError = true
                    self.errorDescription = "resposta do servidor sem sucesso"
                }
            })
            .store(in: &self.cancellablesCreateSessionWithLogin)
    }

    /// Se o formulario é válido
    /// - Returns: True se o formulario tá correto
    func isValidForm() -> Bool {
        return !self.username.isEmpty && !self.password.isEmpty
    }
}
