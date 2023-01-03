import Foundation

// MARK: - Athlete
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

// MARK: - SummaryGear
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

// MARK: - SummaryClub
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
    public let activity_types: [ActivityType]
    ///The club's city.
    public let city: String?
    ///The club's state or geographical region.
    public let state: String?
    ///The club's country.
    public let country: String?
    ///Whether the club is private.
    public let `private`: Bool
    ///The club's member count.
    public let member_count: Int?
    ///Whether the club is featured or not.
    public let featured: Bool?
    ///Whether the club is verified or not.
    public let verified: Bool?
    ///The club's vanity URL.
    public let url: URL?
}

public enum ActivityType: String, Decodable, Equatable {
case AlpineSki
case BackcountrySki
case Canoeing
case Crossfit
case EBikeRide
case Elliptical
case Golf
case Handcycle
case Hike
case IceSkate
case InlineSkate
case Kayaking
case Kitesurf
case NordicSki
case Ride
case RockClimbing
case RollerSki
case Rowing
case Run
case Sail
case Skateboard
case Snowboard
case Snowshoe
case Soccer
case StairStepper
case StandUpPaddling
case Surfing
case Swim
case Velomobile
case VirtualRide
case VirtualRun
case Walk
case WeightTraining
case Wheelchair
case Windsurf
case Workout
case Yoga
}

public enum MeasurementPreference: String, Decodable, Equatable {
    case feet
    case meters
}
