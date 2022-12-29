import Foundation

public struct Athlete: Decodable, Equatable {
    public let id: Int?
    public let username: String?
    public let firstname: String?
    public let lastname: String?
    public let profile: URL?
}
