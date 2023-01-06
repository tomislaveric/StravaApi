import Foundation

struct Endpoint {
    enum Subtype: String {
        case zones
        case streams
        case kudos
        case comments
        case laps
        case stats
    }
    
    static let baseUrl = "https://www.strava.com/api/v3"
    static var athleteActivities: String {
        "\(self.baseUrl)/athlete/activities"
    }
    static func athlete(id: Int? = nil, subType: Subtype? = nil) -> String {
        if let id = id, let type = subType {
            return "\(self.baseUrl)/athlete/\(id)/\(type.rawValue)"
        }
        else if let type = subType {
            return "\(self.baseUrl)/athlete/\(type.rawValue)"
        } else {
            return "\(self.baseUrl)/athlete"
        }
        
    }
    static func activity(id: Int, subType: Subtype? = nil) -> String {
        if let type = subType {
            return "\(self.baseUrl)/activities/\(id)/\(type.rawValue)"
        } else {
            return "\(self.baseUrl)/activities/\(id)"
        }
    }
}
