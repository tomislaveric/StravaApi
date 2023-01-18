import Foundation

public struct Zones: Decodable, Equatable {
    /// An instance of ``HeartRateZoneRanges``.
    public let heart_rate: HeartRateZoneRanges?
    /// An instance of ``PowerZoneRanges``.
    public let power: PowerZoneRanges?
}
