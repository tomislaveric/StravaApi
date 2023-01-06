import Foundation

// MARK: - Kudo
/// This is a swift representation of  Kudo
public struct Kudo: Decodable, Equatable {
    ///Kudo giving users firstname
    public let firstname: String?
    ///Kudo giving users lastname
    public let lastname: String?
}
