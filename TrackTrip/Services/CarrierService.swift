
import OpenAPIRuntime
import OpenAPIURLSession

typealias Carrier = Components.Schemas.Carrier

protocol CarrierProtocol {
    func getCarrierInfo(code: String) async throws -> Carrier
}

final class CarrierService: CarrierProtocol {
    
    private let apiKey: String
    private let client: Client
    
    init(apiKey: String, client: Client) {
        self.apiKey = apiKey
        self.client = client
    }
    
    func getCarrierInfo(code: String) async throws -> Carrier {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apiKey,
            code: code))
        
        return try response.ok.body.json.carrier
    }
}
