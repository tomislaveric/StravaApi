import Foundation

//  MARK: Protocol functions
/// Activities related endpoint requests
extension StravaApiImpl {
    public func getActivityStreams(by id: Int, keys: [StreamKey]) async throws -> StreamSet {
        guard let endpoint = URL(string: Endpoint.activity(id: id, subType: .streams)) else {
            throw StravaApiError.badUrl
        }
        let params: KeyValuePairs<String, Any?> = [
            "keys" : keys.map { $0.rawValue }.joined(separator: ","),
            "key_by_type": true
        ]
        return try await handleRequest(url: endpoint, type: .GET, params: params)
    }
}
