import Foundation

// MARK: - Split
/// This is a swift representation of current Split
/// source: https://developers.strava.com/docs/reference/#api-models-Split
public struct Split: Decodable, Equatable {
    ///The average speed of this split, in meters per second
    public let average_speed: Double?
    ///The distance of this split, in meters
    public let distance: Double?
    ///The elapsed time of this split, in seconds
    public let elapsed_time: Int?
    ///The elevation difference of this split, in meters
    public let elevation_difference: Double?
    ///The pacing zone of this split
    public let pace_zone: Int?
    ///The moving time of this split, in seconds
    public let moving_time: Int?
}
