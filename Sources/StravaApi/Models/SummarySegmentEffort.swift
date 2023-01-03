import Foundation

// MARK: - SummarySegmentEffort
/// This is a swift representation of current SummarySegmentEffort
/// source: https://developers.strava.com/docs/reference/#api-models-SummarySegmentEffort
public struct SummarySegmentEffort: Decodable, Equatable {
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
}
