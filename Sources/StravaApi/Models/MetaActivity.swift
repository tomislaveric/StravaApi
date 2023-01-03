import Foundation

// MARK: - MetaActivity
/// This is a swift representation of current MetaActivity
/// source: https://developers.strava.com/docs/reference/#api-models-MetaActivity
public struct MetaActivity: Decodable, Equatable {
    ///The unique identifier of the activity
    public let id: Double?
}
