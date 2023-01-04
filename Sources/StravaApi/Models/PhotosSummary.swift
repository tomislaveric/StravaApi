import Foundation

// MARK: - PhotosSummary
/// This is a swift representation of current PhotosSummary
/// source: https://developers.strava.com/docs/reference/#api-models-PhotosSummary
public struct PhotosSummary: Decodable, Equatable {
    public let id: Int?
    public let source: Int?
    public let unique_id: String?
    public let urls: String?
}
