
import Foundation

struct FilterOptions: Equatable {
    var selectedTimes: Set<TimeOfDay> = []
    
    var showTransfers: Bool? = nil
    
    static let empty = FilterOptions()
    
    var isActive: Bool {
        self != .empty
    }
}
