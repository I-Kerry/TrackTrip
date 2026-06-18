
import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.Copyright

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> Copyright
}

final class CopyrightService: BaseService, CopyrightServiceProtocol {

    func getCopyright() async throws -> Copyright {
        let response = try await client.getCopyright(query: .init(apikey: apiKey))
        
        return try response.ok.body.json.copyright
    }
}
