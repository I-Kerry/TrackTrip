
import OpenAPIRuntime
import OpenAPIURLSession

typealias StationThread = Components.Schemas.ThreadStationsResponse

protocol StationThreadProtocol: Sendable {
    func getRouteStations(uid: String) async throws -> StationThread
}

final class StationThreadService: BaseService, StationThreadProtocol, @unchecked Sendable {
    
    func getRouteStations(uid: String) async throws -> StationThread {
        let response = try await client.getRouteStations(query: .init(
            apikey: apiKey,
            uid: uid))
        
        return try response.ok.body.json
    }
}
