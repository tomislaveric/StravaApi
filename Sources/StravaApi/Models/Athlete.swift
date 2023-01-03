import Foundation

// MARK: - Athlete
/// This is a swift representation of current Athlete
/// source: https://developers.strava.com/docs/reference/#api-models-Athlete
public struct Athlete: Decodable, Equatable {
    ///The unique identifier of the athlete
    public let id: Double?
    ///Resource state, indicates level of detail. Possible values: 1 -> "meta", 2 -> "summary", 3 -> "detail"
    public let resource_state: Int?
    ///The athlete's user name.
    public let username: String?
    ///The athlete's first name.
    public let firstname: String?
    ///The athlete's last name.
    public let lastname: String?
    ///The athlete's city.
    public let city: String?
    ///The athlete's state or geographical region.
    public let state: String?
    ///The athlete's country.
    public let country, sex: String?
    @available(*, deprecated, message: "Deprecated. Use summit field instead. Whether the athlete has any Summit subscription. ")
    public let premium: Bool?
    ///Whether the athlete has any Summit subscription.
    public let summit: Bool?
    ///The time at which the athlete was created.
    public let created_at: Date?
    ///The time at which the athlete was last updated.
    public let updated_at: Date?
    ///URL to a 62x62 pixel profile picture.
    public let profile_medium: URL?
    ///URL to a 124x124 pixel profile picture.
    public let profile: URL?
    ///The athlete's follower count.
    public let follower_count: Int?
    ///The athlete's friend count.
    public let friend_count: Int?
    ///The athlete's preferred unit system. May take one of the following values: feet, meters
    public let measurement_preference: MeasurementPreference?
    ///he athlete's FTP (Functional Threshold Power).
    public let ftp: Int?
    ///The athlete's weight.
    public let weight: Int?
    ///The athlete's clubs.
    public let clubs: [SummaryClub]?
    ///The athlete's bikes.
    public let bikes: [SummaryGear]?
    ///The athlete's shoes.
    public let shoes: [SummaryGear]?
}

public enum MeasurementPreference: String, Decodable, Equatable {
    case feet
    case meters
}
