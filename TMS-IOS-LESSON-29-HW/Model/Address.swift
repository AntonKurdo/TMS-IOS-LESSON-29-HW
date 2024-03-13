import Foundation

struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}
