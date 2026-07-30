
import OpenAPIRuntime
import OpenAPIURLSession

typealias Carrier = Components.Schemas.Carrier

protocol CarrierProtocol: Sendable {
    func getCarrierInfo(code: String) async throws -> Carrier
}

final class CarrierService: BaseService, CarrierProtocol, @unchecked Sendable {

    func getCarrierInfo(code: String) async throws -> Carrier {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apiKey,
            code: code))
        
        return try response.ok.body.json.carrier
    }
}
