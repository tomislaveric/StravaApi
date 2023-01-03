import Foundation

// MARK: - DetailedActivity
/// source: https://developers.strava.com/docs/reference/#api-models-DetailedActivity
public struct DetailedActivity: Decodable, Equatable {
    public let id: Int
    public let resource_state: Int?
    public let athlete: Athlete?
    public let name: String?
    public let distance: Double?
    public let moving_time, elapsed_time, total_elevation_gain: Int?
    public let type, sport_type: String?
    public let workout_type: Int?
    public let start_date, start_date_local: String?
    public let timezone: String?
    public let utc_offset: Int?
    public let location_city, location_state: String?
    public let location_country: String?
    public let achievement_count, kudos_count, comment_count, athlete_count: Int?
    public let photo_count: Int?
    public let map: Map?
    public let trainer, commute, manual, welcome_private: Bool?
    public let visibility: String?
    public let flagged: Bool?
    public let gear_id: String?
    public let start_latlng, end_latlng: [Double]?
    public let average_speed, max_speed, average_cadence: Double?
    public let average_temp: Int?
    public let average_watts: Double?
    public let max_watts, weighted_average_watts: Int?
    public let kilojoules: Double?
    public let device_watts, has_heartrate: Bool?
    public let average_heartrate: Double?
    public let max_heartrate: Int?
    public let heartrate_optOut, display_hide_heartrate_option: Bool?
    public let elev_high, elev_low: Double?
    public let upload_id: Int?
    public let upload_id_str, external_id: String?
    public let from_accepted_tag: Bool?
    public let pr_count, total_photo_count: Int?
    public let has_kudoed: Bool?
}

// MARK: - Map
public struct Map: Decodable, Equatable {
    public let id, summary_polyline: String?
    public let resource_state: Int?
}
