import Foundation

// MARK: Stream
// https://developers.strava.com/docs/reference/#api-models-HeartrateStream
public struct Stream: Decodable, Equatable {
    /// The number of data points in this stream
    public let original_size: Int?
    /// The level of detail (sampling) in which this stream was returned May take one of the following values: low, medium, high
    public let resolution: Resolution?
    /// The base series used in the case the stream was downsampled May take one of the following values: distance, time
    public let series_type: SeriesType?
    /// The sequence of heart rate values for this stream, in beats per minute
    public let data: [Double]?
}

public enum Resolution: String, Decodable {
    case low
    case medium
    case high
}

public enum SeriesType: String, Decodable {
    case distance
    case time
}
