import Foundation

/// This is a swift representation of current SummaryClub
/// source: https://developers.strava.com/docs/reference/#api-models-SummaryClub
public struct SummaryClub: Decodable, Equatable {
    ///The club's unique identifier.
    public let id: Double
    ///Resource state, indicates level of detail. Possible values: 1 -> "meta", 2 -> "summary", 3 -> "detail"
    public let resource_state: Int?
    ///The club's name.
    public let name: String?
    ///URL to a 60x60 pixel profile picture.
    public let profile_medium: URL?
    ///URL to a ~1185x580 pixel cover photo.
    public let cover_photo: URL?
    ///URL to a ~360x176 pixel cover photo.
    public let cover_photo_small: URL?
    ///Deprecated. Prefer to use activity_types. May take one of the following values: cycling, running, triathlon, other
    public let sport_type: String?
    ///The activity types that count for a club. This takes precedence over sport_type.
    public let activity_types: [SportType]?
    ///The club's city.
    public let city: String?
    ///The club's state or geographical region.
    public let state: String?
    ///The club's country.
    public let country: String?
    ///Whether the club is private.
    public let `private`: Bool?
    ///The club's member count.
    public let member_count: Int?
    ///Whether the club is featured or not.
    public let featured: Bool?
    ///Whether the club is verified or not.
    public let verified: Bool?
    ///The club's vanity URL.
    public let url: String?
}
