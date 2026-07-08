

import Foundation

enum Services {
    static let allStations: AllStationsProtocol = AllStationsService(
        apiKey: ApiKey.apikey,
        client: APIClient.shared)
}
