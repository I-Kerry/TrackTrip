

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

enum APIClient {
    static let shared: Client = {
        Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
    }()
}
