import Foundation

public struct SummaryAthlete: Decodable, Equatable {
    /// The unique identifier of the athlete
    public let id: Double?
    /// Resource state, indicates level of detail. Possible values: 1 -> "meta", 2 -> "summary", 3 -> "detail"
    public let resource_state: Int?
    /// The athlete's first name.
    public let firstname: String?
    /// The athlete's last name.
    public let lastname: String?
    /// URL to a 62x62 pixel profile picture.
    public let profile_medium: URL?
    /// URL to a 124x124 pixel profile picture.
    public let profile: URL?
    /// The athlete's city.
    public let city: String?
    /// The athlete's state or geographical region.
    public let state: String?
    /// The athlete's country.
    public let country: String?
    /// The athlete's sex. May take one of the following values: M, F
    public let sex: String?
    @available(*, deprecated, message: "Deprecated. Use summit field instead. Whether the athlete has any Summit subscription.")
    public let premium: Bool?
    /// Whether the athlete has any Summit subscription.
    public let summit: Bool?
    /// The time at which the athlete was created.
    public let created_at: Date?
    /// The time at which the athlete was last updated.
    public let updated_at: Date?
}
