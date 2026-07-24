

import Foundation

enum Services {
    static let allStations: AllStationsProtocol = AllStationsService(
        apiKey: ApiKey.apikey,
        client: APIClient.shared)
    
    static let scheduleBetweenStations: ScheduleBetweenStationsProtocol = ScheduleBetweenStationsService(
        apiKey: ApiKey.apikey,
        client: APIClient.shared)
    
    static let carrier: CarrierProtocol = CarrierService(
        apiKey: ApiKey.apikey,
        client: APIClient.shared)
    
    static let copyright: CopyrightServiceProtocol = CopyrightService(
        apiKey: ApiKey.apikey,
        client: APIClient.shared)
}
