

import Foundation

enum Services {
    static let allStations: AllStationsProtocol = AllStationsService(
        apiKey: ApiKey.apikey,
        client: APIClient.shared)
    
    static let scheduleBetweenStations: ScheduleBetweenStationsProtocol = ScheduleBetweenStationsService(
        apiKey: ApiKey.apikey,
        client: APIClient.shared)
}
