
import Foundation

enum AppError {
    case noInternet
    case server
    
    var title: String {
        switch self {
        case .noInternet:
            "Нет интернета"
        case .server:
            "Ошибка сервера"
        }
    }
    
    var imageName: String {
        switch self {
        case .noInternet:
            "internetError"
        case .server:
            "serverError"
        }
    }
    
    static func from(_ error: Error) -> AppError {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost, .timedOut, .cannotLoadFromNetwork:
                return .noInternet
            default :
                return .server
            }
        }
        
        return .server
    }
}
