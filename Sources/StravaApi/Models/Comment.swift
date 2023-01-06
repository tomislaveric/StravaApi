import Foundation

public struct Comment: Decodable {
    /// The unique identifier of this comment
    public let id: Double?
    /// The identifier of the activity this comment is related to
    public let activity_id: Double?
    /// The content of the comment
    public let text: String?
    /// The time at which this comment was created.
    public let created_at: Date?
    /// An instance of ``SummaryAthlete``.
    public let athlete: SummaryAthlete?
}
