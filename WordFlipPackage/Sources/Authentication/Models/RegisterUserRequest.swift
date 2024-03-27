import UIKit

public struct RegisterUserRequest {
    let username: String
    let email: String
    let password: String

    public init(username: String, eMail: String, password: String) {
        self.username = username
        self.email = eMail
        self.password = password
    }
}
