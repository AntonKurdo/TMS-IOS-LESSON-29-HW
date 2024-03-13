import Foundation

struct User: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}
