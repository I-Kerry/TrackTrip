
import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleBetweenStations = Components.Schemas.Segments

protocol ScheduleBetweenStationsProtocol: Sendable {
    func getScheduleBetweenStations(from: String, to: String, transfers: Bool?) async throws -> ScheduleBetweenStations
}

final class ScheduleBetweenStationsService: BaseService, ScheduleBetweenStationsProtocol, @unchecked Sendable {

    func getScheduleBetweenStations(from: String, to: String, transfers: Bool?) async throws -> ScheduleBetweenStations {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apiKey,
            from: from,
            to: to,
            transfers: transfers))
        return try response.ok.body.json
    }
}
