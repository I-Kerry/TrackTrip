

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

enum APIClient {
    
    static let shared: Client = {
        guard let url = try? Servers.Server1.url() else {
                fatalError("Invalid server URL")
            }
        return Client(
            serverURL: url,
            transport: URLSessionTransport()
        )
    }()
}
