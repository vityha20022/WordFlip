import XCTest
import FirebaseAuth
import Authentication

final class WordFlipUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        let tabbarProfileBytton = app.buttons["TabbarProfileButtonIdentifier"]
        if tabbarProfileBytton.exists {
            tabbarProfileBytton.tap()

            let profileViewController = app.otherElements["ProfileViewControllerIdentifier"]
            XCTAssertTrue(profileViewController.exists)
        } else {
            let tabbarProfileBytton = app.buttons["SignInButtonIdentifier"]
            XCTAssertTrue(tabbarProfileBytton.exists)
            tabbarProfileBytton.tap()
            
            let profileViewController = app.otherElements["AuthViewControllerIdentifier"]
            XCTAssertTrue(profileViewController.exists)
        }
    }
}
