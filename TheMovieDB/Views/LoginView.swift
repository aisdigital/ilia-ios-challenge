//
//  LoginView.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import SwiftUI
import AlertToast

/// Tela de login
struct LoginView: View {
    // MARK: - Properties

    /// Variaveis de segurança
    @EnvironmentObject var securitySettings: SecuritySettings

    /// View model da tela de login
    @StateObject var viewModel = LoginViewModel()

    /// Se vai ser mostrado o password na tela
    @State var isSecured: Bool = true
    /// O campo que tá em foco nesse momento
    @FocusState private var focusedField: Field?

    /// Usado para os campos de foco
    enum Field {
        case username
        case password
    }

    // MARK: - View

    /// Formulario de login
    var forms: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Digite seus dados para continuar.")
                .font(.gilroySemiBold16)
                .foregroundColor(.primary)

            Text(self.viewModel.username.isEmpty ? "" : "Username")
                .font(.robotoMedium12)
                .foregroundColor(.neutral)
                .padding(.top, 24)

            TextField("Username", text: self.$viewModel.username)
                .foregroundColor(.neutral2)
                .textFieldStyle(.roundedBorder)
                .focused(self.$focusedField, equals: .username)
                .textContentType(.emailAddress)
                .submitLabel(.next)
                .colorScheme(.light)

            Text(self.viewModel.password.isEmpty ? "" : "Senha")
                .font(.robotoMedium12)
                .foregroundColor(.neutral)
                .padding(.top, 22)

            ZStack(alignment: .trailing) {
                if self.isSecured {
                    SecureField("Senha", text: self.$viewModel.password)
                        .foregroundColor(.neutral2)
                        .textFieldStyle(.roundedBorder)
                        .focused(self.$focusedField, equals: .password)
                        .textContentType(.password)
                        .submitLabel(.join)
                        .colorScheme(.light)
                }
                else {
                    TextField("Senha", text: self.$viewModel.password)
                        .foregroundColor(.neutral2)
                        .textFieldStyle(.roundedBorder)
                        .focused(self.$focusedField, equals: .password)
                        .textContentType(.password)
                        .submitLabel(.join)
                        .colorScheme(.light)
                }

                Button {
                    self.isSecured.toggle()
                } label: {
                    Image(systemName: self.isSecured ? "eye.slash" : "eye")
                        .accentColor(.gray)
                }
            }
        }
        .onSubmit {
            switch self.focusedField {
            case .username:
                self.focusedField = .password
            case .password:
                debugPrint("LoginView.forms: onSubmit")
            case .none:
                debugPrint("LoginView.forms: erro no onSubmit")
            }
        }
    }

    /// Botão para fazer a requisição de autenticação
    var submitButton: some View {
        Button {
            self.focusedField = nil
            if self.viewModel.isValidForm() {
                self.viewModel.signIn()
            }
        } label: {
            Text("ENTRAR")
                .padding()
                .frame(maxWidth: .infinity)
                .background(self.viewModel.isValidForm() ? Color.primary : Color.neutral)
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
        .padding(.top, 22)
    }

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Bem-Vindo(a).")
                            .font(.gilroyBold40)

                        Text("Milhões de Filmes, Explore já.")
                            .font(.robotoLight24)
                    }
                    .foregroundColor(.white)
                    .padding(.leading, 24.0)

                    Spacer()
                }

                VStack(alignment: .leading, spacing: 0) {
                    VStack(spacing: 0) {
                        self.forms

                        self.submitButton
                    }
                    .padding(.vertical, 24)
                    .padding(.horizontal, 24)
                }
                .background(Color.white)
                .padding(.top, 31)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RadialGradient(colors: AppConstants.backgroundGradientColors, center: .topLeading, startRadius: 10, endRadius: 800)
        )
        .toast(isPresenting: self.$viewModel.isLoading) {
            AlertToast(type: .loading)
        }
        .toast(isPresenting: self.$viewModel.showError, duration: 2, tapToDismiss: true) {
            AlertToast(displayMode: .hud, type: .error(.red), title: "Erro", subTitle: self.viewModel.errorDescription)
        }
        .toast(isPresenting: self.$viewModel.completedLogin, duration: 2, tapToDismiss: true, alert: {
            AlertToast(displayMode: .hud, type: .complete(.green))
        }, completion: {
            self.securitySettings.isUserLoaded = true
        })
    }
}

/// Preview da tela de login
struct LoginView_Previews: PreviewProvider {
    // MARK: - View

    static var previews: some View {
        LoginView()
    }
}

