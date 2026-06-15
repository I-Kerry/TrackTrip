
import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias AllStations = Components.Schemas.AllStationsResponse

protocol AllStationsProtocol {
    func getAllStations() async throws -> AllStations
}

final class AllStationsService: AllStationsProtocol {
    private let apiKey: String
    private let client: Client
    
    init(apiKey: String, client: Client) {
        self.apiKey = apiKey
        self.client = client
    }
    
    func getAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(query: .init(apikey: apiKey))
        
        let responseBody = try response.ok.body.html

        let limit = 50 * 1024 * 1024
        
        let fullData = try await Data(collecting: responseBody, upTo: limit)
        
//        var fullData = Data()
        
//        for try await chunk in try response.ok.body.html {
//            fullData.append(contentsOf: chunk)
//        }
        
        let allStation = try JSONDecoder().decode(AllStations.self, from: fullData)
        return allStation
    }
}
