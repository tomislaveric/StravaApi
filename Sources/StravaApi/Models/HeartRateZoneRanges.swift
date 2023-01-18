import Foundation
public struct HeartRateZoneRanges: Decodable, Equatable {
    public let custom_zones: Bool?
    public let zones: [ZoneRange]?
}

public struct PowerZoneRanges: Decodable, Equatable {
    public let zones: [ZoneRange]?
}

public struct ZoneRange: Decodable, Equatable {
    public let min: Int?
    public let max: Int?
}
