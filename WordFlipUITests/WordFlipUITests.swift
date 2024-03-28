import XCTest

final class WordFlipUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

        let signInButton = app.buttons["SignInButtonIdentifier"]
        XCTAssertTrue(signInButton.exists)
        signInButton.tap()

        let authViewController = app.otherElements["AuthViewControllerIdentifier"]
        XCTAssertTrue(authViewController.exists)
    }
}
