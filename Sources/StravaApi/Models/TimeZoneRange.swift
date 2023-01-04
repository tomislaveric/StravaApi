import Foundation

// MARK: TimedZoneRange
///A union type representing the time spent in a given zone.
///source: https://developers.strava.com/docs/reference/#api-models-#/TimedZoneRange
public struct TimedZoneRange: Decodable, Equatable {
    ///The minimum value in the range.
    public let min: Int?
    ///The maximum value in the range.
    public let max: Int?
    ///The number of seconds spent in this zone
    public let time: Int?
}
