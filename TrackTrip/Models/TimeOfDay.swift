
import Foundation

enum TimeOfDay: Hashable, CaseIterable {
    case morning, day, evening, night
    
    var title: String {
        switch self {
        case .morning: return "Утро 06:00 - 12:00"
        case .day: return "День 12:00 - 18:00"
        case .evening: return "Вечер 18:00 - 00:00"
        case .night: return "Ночь 00:00 - 06:00"
        }
    }
    
    static func from(hour: Int) -> TimeOfDay {
        switch hour {
        case 6..<12: return .morning
        case 12..<18: return .day
        case 18..<24: return .evening
        default: return .night
        }
    }
}
