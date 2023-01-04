import Foundation

public struct DetailedActivityParams {
    public let includeAllEfforts: Bool
    public init(incldueAllEfforts: Bool = false) {
        self.includeAllEfforts = incldueAllEfforts
    }
}
