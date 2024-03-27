public protocol AuthServiceProtocol {
    func registerUser(with registerUserRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void)

    func logInUser(with authUserRequest: AuthUserRequest, completion: @escaping (Bool, Error?) -> Void)
}
