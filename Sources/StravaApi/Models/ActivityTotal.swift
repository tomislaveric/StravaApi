import Foundation

// MARK: - ActivityTotal
/// A roll-up of metrics pertaining to a set of activities. Values are in seconds and meters.
/// source: https://developers.strava.com/docs/reference/#api-models-ActivityTotal

public struct ActivityTotal: Decodable, Equatable {
    /// The number of activities considered in this total.
    public let count: Int?
    /// The total distance covered by the considered activities.
    public let distance: Double?
    /// The total moving time of the considered activities.
    public let moving_time: Int?
    /// The total elapsed time of the considered activities.
    public let elapsed_time: Int?
    /// The total elevation gain of the considered activities.
    public let elevation_gain: Double?
    /// The total number of achievements of the considered activities.
    public let achievement_count: Int?
}
