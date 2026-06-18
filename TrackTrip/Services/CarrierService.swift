
import OpenAPIRuntime
import OpenAPIURLSession

typealias Carrier = Components.Schemas.Carrier

protocol CarrierProtocol {
    func getCarrierInfo(code: String) async throws -> Carrier
}

final class CarrierService: BaseService, CarrierProtocol {

    func getCarrierInfo(code: String) async throws -> Carrier {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apiKey,
            code: code))
        
        return try response.ok.body.json.carrier
    }
}
