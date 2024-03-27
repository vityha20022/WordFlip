import UIKit

public struct RegisterUserRequest {
    let username: String
    let eMail: String
    let password: String

    public init(username: String, eMail: String, password: String) {
        self.username = username
        self.eMail = eMail
        self.password = password
    }
}
