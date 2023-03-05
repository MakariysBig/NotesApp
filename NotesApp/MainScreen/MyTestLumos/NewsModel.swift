import Foundation

// MARK: - Welcome
struct NewsModel: Codable {
    let hasErrors: Bool
    let items: [News]
}

// MARK: - Item
struct News: Codable {
    let modelTitle: String
    let modelImage: String
    let modelDateTime: String
    let modelText: String
    var isRead = false

    enum CodingKeys: String, CodingKey {
        case modelTitle = "model_title"
        case modelImage = "model_image"
        case modelDateTime = "model_dateTime"
        case modelText = "model_text"
    }
}
