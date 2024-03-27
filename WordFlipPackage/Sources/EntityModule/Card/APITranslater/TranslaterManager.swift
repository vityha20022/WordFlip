import Foundation

enum TranslationError: Error {
    case invalidURL
    case noDataReceived
    case decodingError
    case otherError(Error)
}

enum Language: String {
    case english = "en"
    case russian = "ru"
}

enum APIEndpoint {
    case translate(text: String, source: Language, target: Language, key: String)
    
    var baseURL: String {
        return "https://www.googleapis.com/language/translate/v2"
    }
    
    var urlString: String {
        switch self {
        case .translate(let text, let source, let target, let key):
            let queryItems = [
                URLQueryItem(name: "key", value: key),
                URLQueryItem(name: "q", value: text),
                URLQueryItem(name: "source", value: source.rawValue),
                URLQueryItem(name: "target", value: target.rawValue)
            ]
            
            var urlComponents = URLComponents(string: baseURL)
            urlComponents?.queryItems = queryItems
            
            return urlComponents?.url?.absoluteString ?? ""
        }
    }
}


class GoogleTranslateManager {
    let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func translate(endpoint: APIEndpoint, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: endpoint.urlString) else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let translateResponse = try decoder.decode(GoogleTranslateResponse.self, from: data)
                let translatedText = translateResponse.data.translations.first?.translatedText ?? ""
                DispatchQueue.main.async {
                    completion(.success(translatedText))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
