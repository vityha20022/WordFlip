struct TranslateResponse: Decodable {
    let data: Data
}

struct Data: Decodable {
    let translations: [Translation]
}

struct Translation: Decodable {
    let translatedText: String
}
