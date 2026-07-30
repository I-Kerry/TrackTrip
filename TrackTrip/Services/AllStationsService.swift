
import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias AllStations = Components.Schemas.AllStationsResponse

protocol AllStationsProtocol: Sendable {
    func getAllStations() async throws -> AllStations
}

final class AllStationsService: BaseService, AllStationsProtocol, @unchecked Sendable {
    
    func getAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(query: .init(apikey: apiKey))
        
        let responseBody = try response.ok.body.html

        let limit = 50 * 1024 * 1024
        
        let fullData = try await Data(collecting: responseBody, upTo: limit)
        
        let allStation = try JSONDecoder().decode(AllStations.self, from: fullData)
        return allStation
    }
}
