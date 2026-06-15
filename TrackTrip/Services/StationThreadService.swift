
import OpenAPIRuntime
import OpenAPIURLSession

typealias StationThread = Components.Schemas.ThreadStationsResponse

protocol StationThreadProtocol {
    func getRouteStations(uid: String) async throws -> StationThread
}

final class StationThreadService: StationThreadProtocol {
    
    private let apiKey: String
    private let client: Client
    
    init(apiKey: String, client: Client) {
        self.apiKey = apiKey
        self.client = client
    }
    
    func getRouteStations(uid: String) async throws -> StationThread {
        let response = try await client.getRouteStations(query: .init(
            apikey: apiKey,
            uid: uid))
        
        return try response.ok.body.json
    }
}
