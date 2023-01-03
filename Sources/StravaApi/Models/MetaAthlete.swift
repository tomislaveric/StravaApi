import Foundation

// MARK: - MetaAthlete
/// This is a swift representation of current MetaAthlete
/// source: https://developers.strava.com/docs/reference/#api-models-MetaAthlete
public struct MetaAthlete: Decodable, Equatable {
    ///The unique identifier of the athlete
    public let id: Double?
}
