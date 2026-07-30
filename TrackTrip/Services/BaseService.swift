
import Foundation
class BaseService: @unchecked Sendable {
    let apiKey: String
    let client: Client
    
    init(apiKey: String, client: Client) {
        self.apiKey = apiKey
//        self.client = APIClient.shared
        self.client = client
    }
}

