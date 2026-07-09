
import Foundation

struct City: Hashable, Identifiable {
    var id: String
    let name: String
    let station: [Station]
}
