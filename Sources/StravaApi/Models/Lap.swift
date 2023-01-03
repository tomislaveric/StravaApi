import Foundation

// MARK: - Lap
/// This is a swift representation of current Lap
/// source: https://developers.strava.com/docs/reference/#api-models-Lap
public struct Lap: Decodable, Equatable {
    ///The unique identifier of this lap
    public let id: Double?
    ///An instance of MetaActivity.
    public let activity: MetaActivity
    ///An instance of MetaAthlete.
    public let athlete: MetaAthlete
    ///The lap's average cadence
    public let average_cadence: Double?
    ///The lap's average speed
    public let average_speed: Double?
    ///The lap's distance, in meters
    public let distance: Double?
    ///The lap's elapsed time, in seconds
    public let elapsed_time: Int?
    ///The start index of this effort in its activity's stream
    public let start_index: Int?
    ///The end index of this effort in its activity's stream
    public let end_index: Int?
    ///The index of this lap in the activity it belongs to
    public let lap_index: Int?
    ///The maximum speed of this lat, in meters per second
    public let max_speed: Double?
    ///The lap's moving time, in seconds
    public let moving_time: Int?
    ///The name of the lap
    public let name: String?
    ///The athlete's pace zone during this lap
    public let pace_zone: Int?
    ///An instance of integer.
    public let split: Int?
    ///The time at which the lap was started.
    public let start_date: Date?
    ///The time at which the lap was started in the local timezone.
    public let start_date_local: Date?
    ///The elevation gain of this lap, in meters
    public let total_elevation_gain: Double?
}
