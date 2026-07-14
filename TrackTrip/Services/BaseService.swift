
import Foundation
class BaseService {
    let apiKey: String
    let client: Client
    
    init(apiKey: String, client: Client) {
        self.apiKey = apiKey
        self.client = APIClient.shared
    }
}

