
import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestStations = Components.Schemas.Stations

protocol NearestStationsServiceProtocol: Sendable {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

final class NearestStationsService: BaseService, NearestStationsServiceProtocol, @unchecked Sendable {

    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(apikey: apiKey,
                                                                        lat: lat,
                                                                        lng: lng,
                                                                        distance: distance)
        )
        return try response.ok.body.json
    }
}
