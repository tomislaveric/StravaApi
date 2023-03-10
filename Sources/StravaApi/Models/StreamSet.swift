import Foundation

public struct StreamSet: Decodable, Equatable {
    /// An instance of TimeStream.
    public let time: Stream?
    /// An instance of DistanceStream.
    public let distance: Stream?
    /// An instance of LatLngStream.
    public let latlng: Stream?
    /// An instance of AltitudeStream.
    public let altitude: Stream?
    /// An instance of SmoothVelocityStream.
    public let velocity_smooth: Stream?
    /// An instance of HeartrateStream.
    public let heartrate: Stream?
    /// An instance of CadenceStream.
    public let cadence: Stream?
    /// An instance of PowerStream.
    public let watts: Stream?
    /// An instance of TemperatureStream.
    public let temp: Stream?
    /// An instance of MovingStream.
    public let moving: Stream?
    /// An instance of SmoothGradeStream.
    public let grade_smooth: Stream?
}

public enum StreamKey: String {
case time
case distance
case latlng
case altitude
case velocity_smooth
case heartrate
case cadence
case watts
case temp
case moving
case grade_smooth
}
