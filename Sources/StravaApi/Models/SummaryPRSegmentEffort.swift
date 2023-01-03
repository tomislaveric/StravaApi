import Foundation

// MARK: - SummaryPRSegmentEffort
/// This is a swift representation of current SummaryPRSegmentEffort
/// source: https://developers.strava.com/docs/reference/#api-models-SummaryPRSegmentEffort
public struct SummaryPRSegmentEffort: Decodable, Equatable {
    ///The unique identifier of the activity related to the PR effort.
    public let pr_activity_id: Double?
    ///The elapsed time ot the PR effort.
    public let pr_elapsed_time: Int?
    ///The time at which the PR effort was started.
    public let pr_date: Date?
    ///Number of efforts by the authenticated athlete on this segment.
    public let effort_count: Int?
}
