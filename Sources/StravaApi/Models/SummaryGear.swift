import Foundation

// MARK: - SummaryGear
/// This is a swift representation of current SummaryGear
/// source: https://developers.strava.com/docs/reference/#api-models-SummaryGear
public struct SummaryGear: Decodable, Equatable {
    ///The gear's unique identifier.
    public let id: String?
    ///Whether this gear's is the owner's default one.
    public let primary: Bool?
    ///Resource state, indicates level of detail. Possible values: 2 -> "summary", 3 -> "detail"
    public let resource_state: Int?
    ///The gear's name.
    public let name: String?
    ///The distance logged with this gear.
    public let distance: Double?
}
