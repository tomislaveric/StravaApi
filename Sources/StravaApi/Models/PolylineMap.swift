import Foundation

// MARK: - PolylineMap
/// This is a swift representation of current PolylineMap
/// source: https://developers.strava.com/docs/reference/#api-models-PolylineMap

public struct PolylineMap: Decodable, Equatable {
    ///The identifier of the map
    public let id: String?
    ///The summary polyline of the map
    public let summary_polyline: String?
    ///Resource state, indicates level of detail. Possible values: 1 -> "meta", 2 -> "summary", 3 -> "detail"
    public let resource_state: Int?
    ///The polyline of the map, only returned on detailed representation of an object
    public let polyline: String?
}
