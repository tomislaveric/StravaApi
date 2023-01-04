import Foundation

public struct AthleteDetailedActivitiesParams {
    public init(before: Int? = nil, after: Int? = nil, page: Int? = nil, perPage: Int? = nil) {
        self.before = before
        self.after = after
        self.page = page
        self.perPage = perPage
    }
    public let before: Int?
    public let after: Int?
    public let page: Int?
    public let perPage: Int?
}
