//
//  RouteModel.swift
//  TrackTrip
//
//  Created by Kirill Maidanovich on 2026/7/8.
//

import Foundation

enum CityField: Hashable {
    case from
    case to
    
    var title: String {
        switch self {
        case .from:
            return "Откуда"
        case .to:
            return "Куда"
        }
    }
}

enum Route: Hashable {
    case citySelection(field: CityField)
    case stationSelection(field: CityField, city: City)
}
