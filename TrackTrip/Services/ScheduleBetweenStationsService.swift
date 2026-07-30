
import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias ScheduleBetweenStations = Components.Schemas.Segments

protocol ScheduleBetweenStationsProtocol: Sendable {
    func getScheduleBetweenStations(from: String, to: String, date: Date, transfers: Bool?) async throws -> ScheduleBetweenStations
}

final class ScheduleBetweenStationsService: BaseService, ScheduleBetweenStationsProtocol, @unchecked Sendable {

    func getScheduleBetweenStations(from: String, to: String, date: Date, transfers: Bool?) async throws -> ScheduleBetweenStations {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apiKey,
            from: from,
            to: to,
            date: Self.dateFormatter.string(from: date),
            transfers: transfers))
        return try response.ok.body.json
    }
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter
    }()
}
