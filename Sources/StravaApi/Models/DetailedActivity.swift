import Foundation

// MARK: - DetailedActivity
/// This is a swift representation of current DetailedActivity
/// source: https://developers.strava.com/docs/reference/#api-models-DetailedActivity
public struct DetailedActivity: Decodable, Equatable {
    ///The unique identifier of the activity
    public let id: Int
    ///Resource state, indicates level of detail. Possible values: 1 -> "meta", 2 -> "summary", 3 -> "detail"
    public let resource_state: Int?
    ///An instance of MetaAthlete
    public let athlete: MetaAthlete?
    ///The name of the activity
    public let name: String?
    ///The description of the activity
    public let description: String?
    ///The activity's distance, in meters
    public let distance: Double?
    ///The activity's moving time, in seconds
    public let moving_time: Int?
    ///The activity's elapsed time, in seconds
    public let elapsed_time: Int?
    ///The activity's total elevation gain.
    public let total_elevation_gain: Double?
    @available(*, deprecated, message: "Deprecated. Prefer to use sport_type")
    public let type: String?
    ///An instance of SportType.
    public let sport_type: SportType?
    ///The activity's workout type
    public let workout_type: Int?
    ///The time at which the activity was started.
    public let start_date: Date?
    ///The time at which the activity was started in the local timezone.
    public let start_date_local: Date?
    ///The timezone of the activity
    public let timezone: String?
    ///The number of achievements gained during this activity
    public let achievement_count: Int?
    ///The number of kudos given for this activity
    public let kudos_count: Int?
    ///The number of comments for this activity
    public let comment_count: Int?
    ///The number of athletes for taking part in a group activity
    public let athlete_count: Int?
    ///The number of Instagram photos for this activity
    public let photo_count: Int?
    ///An instance of PolylineMap
    public let map: PolylineMap?
    ///Whether this activity was recorded on a training machine
    public let trainer: Bool?
    ///Whether this activity is a commute
    public let commute: Bool?
    ///Whether this activity was created manually
    public let manual: Bool?
    ///Whether this activity is private
    public let `private`: Bool?
    ///Whether this activity is flagged
    public let flagged: Bool?
    ///The id of the gear for the activity
    public let gear_id: String?
    ///An instance of SummaryGear.
    public let gear: SummaryGear?
    ///An instance of LatLng.
    public let start_latlng: [Double]?
    ///An instance of LatLng.
    public let end_latlng: [Double]?
    ///The activity's average speed, in meters per second
    public let average_speed: Double?
    ///The activity's max speed, in meters per second
    public let max_speed: Double?
    ///The activities average cadence
    public let average_cadence: Double?
    ///The activities average temperature
    public let average_temp: Int?
    ///Average power output in watts during this activity. Rides only
    public let average_watts: Double?
    ///Rides with power meter data only
    public let max_watts: Int?
    ///Similar to Normalized Power. Rides with power meter data only
    public let weighted_average_watts: Int?
    ///The total work done in kilojoules during this activity. Rides only
    public let kilojoules: Double?
    ///Whether the watts are from a power meter, false if estimated
    public let device_watts: Bool?
    ///Whether this activity was recorded with a heart rate sensor or not
    public let has_heartrate: Bool?
    ///The averate heart rate of the athlete during this activity
    public let average_heartrate: Double?
    ///The maximum heart rate of the athlete during this activity
    public let max_heartrate: Int?
    ///Whether the activity is muted
    public let hide_from_home: Bool?
    ///The activity's lowest elevation, in meters
    public let elev_low: Double?
    ///The activity's highest elevation, in meters
    public let elev_high: Double?
    ///The identifier of the upload that resulted in this activity
    public let upload_id: Double?
    ///The unique identifier of the upload in string format
    public let upload_id_str: String?
    ///The identifier provided at upload time
    public let external_id: String?
    ///The number of Instagram and Strava photos for this activity
    public let total_photo_count: Int?
    ///Whether the logged-in athlete has kudoed this activity
    public let has_kudoed: Bool?
    ///An instance of PhotosSummary.
    public let photos: PhotosSummary?
    ///The number of kilocalories consumed during this activity
    public let calories: Double?
    ///A collection of DetailedSegmentEffort objects.
    public let segment_efforts: [DetailedSegmentEffort]?
    ///The name of the device used to record the activity
    public let device_name: String?
    ///The token used to embed a Strava activity
    public let embed_token: String?
    ///The splits of this activity in metric units (for runs)
    public let splits_metric: [Split]?
    ///The splits of this activity in imperial units (for runs)
    public let splits_standard: Split?
    ///A collection of Lap objects.
    public let laps: [Lap]?
    ///A collection of DetailedSegmentEffort objects.
    public let best_efforts: DetailedSegmentEffort?
}
