import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestCity = Components.Schemas.NearestCityResponse

protocol NearestCityProtocol {
    func getNearestCity(lat: Double, lng: Double) async throws -> NearestCity
}

final class NearestCityService: BaseService, NearestCityProtocol {

    func getNearestCity(lat: Double, lng: Double) async throws -> NearestCity {
        let response = try await client.getNearestCity(query: .init(
            apikey: apiKey,
            lat: lat,
            lng: lng))
        
        return try response.ok.body.json
    }
}
