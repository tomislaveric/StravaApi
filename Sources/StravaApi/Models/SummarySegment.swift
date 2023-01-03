import Foundation

// MARK: - SummarySegment
/// This is a swift representation of current SummarySegment
/// source: https://developers.strava.com/docs/reference/#api-models-SummarySegment
public struct SummarySegment: Decodable, Equatable {
    ///The unique identifier of this segment
    public let id: Double?
    ///The name of this segment
    public let name: String?
    ///May take one of the following values: Ride, Run
    public let activity_type: String?
    ///The segment's distance, in meters
    public let distance: Double?
    ///The segment's average grade, in percents
    public let average_grade: Double?
    ///The segments's maximum grade, in percents
    public let maximum_grade: Double?
    ///The segments's highest elevation, in meters
    public let elevation_high: Double?
    ///The segments's lowest elevation, in meters
    public let elevation_low: Double?
    ///An instance of LatLng.
    public let start_latlng: [Double]?
    ///An instance of LatLng.
    public let end_latlng: [Double]?
    ///The category of the climb [0, 5]. Higher is harder ie. 5 is Hors catégorie, 0 is uncategorized in climb_category.
    public let climb_category: Int?
    ///The segments's city.
    public let city: String?
    ///The segments's state or geographical region.
    public let state: String?
    ///The segment's country.
    public let country: String?
    ///Whether this segment is private.
    public let `private`: Bool?
    ///An instance of SummaryPRSegmentEffort.
    public let athlete_pr_effort: SummaryPRSegmentEffort?
    ///An instance of SummarySegmentEffort.
    public let athlete_segment_stats: SummarySegmentEffort?
}
