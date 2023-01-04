//
//  File.swift
//  
//
//  Created by Tomislav Eric on 04.01.23.
//

import Foundation

// MARK: ActivityZone
///source: https://developers.strava.com/docs/reference/#api-models-ActivityZone
public struct ActivityZone: Decodable, Equatable {
    public let score: Int?
    public let distribution_buckets: [TimedZoneRange]?
    ///May take one of the following values: heartrate, power
    public let type: ZoneType?
    public let sensor_based: Bool?
    public let points: Int?
    public let custom_zones: Bool?
    public let max: Int?
}

public enum ZoneType: String, Decodable {
    case heartrate
    case power
}
