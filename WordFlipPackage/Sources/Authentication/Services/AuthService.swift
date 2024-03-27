import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

public final class AuthService {

    public static let shared = AuthService()

    private init() {

    }

    /// A method to register the user
    /// - Parameters:
    ///   - registerUserRequest: the user's information (email, password, username)
    ///   - completion: a completion with two values...
    ///   - Bool: wasRegistered - whether a user was registered and saved to DataBase correctly
    ///   - Error?: an optional error if Firebase provides one
    public func registerUser(with registerUserRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        let username = registerUserRequest.username
        let eMail = registerUserRequest.email
        let password = registerUserRequest.password
        Database.database().isPersistenceEnabled = true
        Auth.auth().createUser(withEmail: eMail, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }

            let dataBase = Firestore.firestore()
            dataBase.collection("users")
                .document(resultUser.uid)
                .setData([
                    "username": username,
                    "email": eMail,
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
        }

    }

    /// A method to sign in user
    /// - Parameters:
    ///   - authUserRequest: the user's information
    ///   - completion: a completion with two values
    ///   - Bool: wasLoggedIn -  whether a user was logged in correctly
    ///   - Error?: an optional error if Firebase provides one
    public func logInUser(with authUserRequest: AuthUserRequest, completion: @escaping (Error?) -> Void) {
        let email = authUserRequest.email
        let password = authUserRequest.password
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }

    /// A method to sign in the user
    /// - Parameter completion: with one value
    /// - Error?: an optional error if Firebase provides one
    public func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
        } catch let error {
            completion(error)
        }
    }

}
