
import Foundation
class BaseService: @unchecked Sendable {
    let apiKey: String
    let client: Client
    
    init(apiKey: String, client: Client) {
        self.apiKey = apiKey
        self.client = client
    }
}

