import Foundation

// MARK: - DetailedActivity
/// This is a swift representation of current DetailedActivity
/// source: https://developers.strava.com/docs/reference/#api-models-DetailedActivity
public struct DetailedSegmentEffort: Decodable, Equatable {
    ///The unique identifier of this effort
    public let id: Double?
    ///The unique identifier of the activity related to this effort
    public let activity_id: Double?
    ///The effort's elapsed time
    public let elapsed_time: Int?
    ///The time at which the effort was started.
    public let start_date: Date?
    ///The time at which the effort was started in the local timezone.
    public let start_date_local: Date?
    ///The effort's distance in meters
    public let distance: Double?
    ///Whether this effort is the current best on the leaderboard
    public let is_kom: Bool?
    ///The name of the segment on which this effort was performed
    public let name: String?
    ///An instance of MetaActivity.
    public let activity: MetaActivity?
    ///An instance of MetaAthlete.
    public let athlete: MetaAthlete?
    ///The effort's moving time
    public let moving_time: Int?
    ///The start index of this effort in its activity's stream
    public let start_index: Int?
    ///The end index of this effort in its activity's stream
    public let end_index: Int?
    ///The effort's average cadence
    public let average_cadence: Double?
    ///The average wattage of this effort
    public let average_watts: Double?
    ///For riding efforts, whether the wattage was reported by a dedicated recording device
    public let device_watts: Bool?
    ///The heart heart rate of the athlete during this effort
    public let average_heartrate: Double?
    ///The maximum heart rate of the athlete during this effort
    public let max_heartrate: Double?
    ///An instance of SummarySegment.
    public let segment: SummarySegment?
    ///The rank of the effort on the global leaderboard if it belongs in the top 10 at the time of upload
    public let kom_rank: Int?
    ///The rank of the effort on the athlete's leaderboard if it belongs in the top 3 at the time of upload
    public let pr_rank: Int?
    ///Whether this effort should be hidden when viewed within an activity
    public let hidden: Bool?
}
