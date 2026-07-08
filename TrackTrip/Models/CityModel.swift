//
//  CityModel.swift
//  TrackTrip
//
//  Created by Kirill Maidanovich on 2026/7/8.
//

import Foundation

struct City: Hashable, Identifiable {
    var id: String
    let name: String
    let station: [Station]
}
