//
//  TheMovieDBUITests.swift
//  TheMovieDBUITests
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import XCTest

class TheMovieDBUITests: XCTestCase {
    let username = "m0rb1u5"
    let password = "a1b2c3d4"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    /// Testa que as credenciais não estão corretas
    func testIncorrectCredentials() throws {
        let app = XCUIApplication()
        app.launch()

        if app.buttons["Logout"].exists {
            app.buttons["Logout"].tap()
        }

        app.textFields["Username"].tap()
        app.textFields["Username"].typeText("Qualquer coisa")
        app.secureTextFields["Senha"].tap()
        app.secureTextFields["Senha"].typeText("1234")

        app.buttons["ENTRAR"].tap()

        sleep(5)

        XCTAssertTrue(app.buttons["ENTRAR"].waitForExistence(timeout: 2))
    }

    /// Testa que as credenciais estão corretas
    func testCorrectCredentials() throws {
        let app = XCUIApplication()
        app.launch()

        if app.buttons["Logout"].exists {
            app.buttons["Logout"].tap()
        }

        app.textFields["Username"].tap()
        app.textFields["Username"].typeText(self.username)
        app.secureTextFields["Senha"].tap()
        app.secureTextFields["Senha"].typeText(self.password)

        app.buttons["ENTRAR"].tap()

        sleep(5)

        XCTAssertFalse(app.buttons["ENTRAR"].waitForExistence(timeout: 2))
    }

    /// Testa se uma busca não foi encontrada
    func testNotFoundSearch() throws {
        let app = XCUIApplication()
        app.launch()

        if !app.buttons["Logout"].exists {
            app.textFields["Username"].tap()
            app.textFields["Username"].typeText(self.username)
            app.secureTextFields["Senha"].tap()
            app.secureTextFields["Senha"].typeText(self.password)

            app.buttons["ENTRAR"].tap()

            sleep(5)
        }

        app.searchFields["Buscar..."].tap()
        app.searchFields["Buscar..."].typeText("Aasdfsdafasdfasdf")

        XCTAssertTrue(app.staticTexts["Sem resultados"].waitForExistence(timeout: 2))
    }

    /// Testa se uma busca teve sucesso
    func testSucessSearch() throws {
        let app = XCUIApplication()
        app.launch()

        if !app.buttons["Logout"].exists {
            app.textFields["Username"].tap()
            app.textFields["Username"].typeText(self.username)
            app.secureTextFields["Senha"].tap()
            app.secureTextFields["Senha"].typeText(self.password)

            app.buttons["ENTRAR"].tap()

            sleep(5)
        }

        app.searchFields["Buscar..."].tap()
        app.searchFields["Buscar..."].typeText("Ven")

        sleep(2)

        XCTAssertTrue(app.images.count > 2)
    }

    /// Testa se foi possível abrir os detalhes de um filme
    func testOpenMovieDetail() throws {
        let app = XCUIApplication()
        app.launch()

        if !app.buttons["Logout"].exists {
            app.textFields["Username"].tap()
            app.textFields["Username"].typeText(self.username)
            app.secureTextFields["Senha"].tap()
            app.secureTextFields["Senha"].typeText(self.password)

            app.buttons["ENTRAR"].tap()

            sleep(5)
        }

        app.searchFields["Buscar..."].tap()
        app.searchFields["Buscar..."].typeText("Venom")

        sleep(2)
        app.images.firstMatch.tap()


        XCTAssertTrue(app.staticTexts["movieTitle"].waitForExistence(timeout: 5))
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
