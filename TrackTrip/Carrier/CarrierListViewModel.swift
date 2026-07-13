import Foundation
import Combine

final class CarrierListViewModel: ObservableObject {
    @Published private(set) var trips: [CarrierTrip] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var filters: FilterOptions = .empty
    
    var fromStation: Station
    var toStation: Station
    
    private let scheduleService: ScheduleBetweenStationsProtocol
    
    init(fromStation: Station, toStation: Station, scheduleService: ScheduleBetweenStationsProtocol = Services.scheduleBetweenStations) {
        self.fromStation = fromStation
        self.toStation = toStation
        self.scheduleService = scheduleService
    }
    
    var filteredTrips: [CarrierTrip] {
        guard !filters.selectedTimes.isEmpty else { return trips }
        return trips.filter { filters.selectedTimes.contains($0.timeOfDay)}
    }
    
//    var filteredTrips: [CarrierTrip] {
//        trips.filter { trip in
//            let matchesTime = filters.selectedTimes.isEmpty || filters.selectedTimes.contains(trip.timeOfDay)
//            
//            let matchesTransfer: Bool
//            
//            switch filters.showTransfers {
//            case nil: matchesTransfer = true
//            case .some(true): matchesTransfer = true
//            case .some(false): matchesTransfer = !trip.hasTransfer
//            }
//            
//            return matchesTime && matchesTransfer
//        }
//    }
    
    func loadTrips() async {
        isLoading = true
        
        defer { isLoading = false }
        
        do {
            let response = try await scheduleService.getSchedualBetweenStations(from: fromStation.code, to: toStation.code, transfers: filters.showTransfers)
            trips = map(response)
        } catch {
            errorMessage = "Вариантов нет"
        }
    }
    
    func applyFilters(_ newFilter: FilterOptions) async {
        filters = newFilter
        await loadTrips()
    }
    
    func map(_ response: ScheduleBetweenStations) -> [CarrierTrip] {
        var result: [CarrierTrip] = []
        
        for segment in response.segments ?? [] {
            guard
                let carrierTitle = segment.thread?.carrier?.title,
                let departure = segment.departure,
                let arrival = segment.arrival,
                let departureDate = ISO8601DateFormatter().date(from: departure)
            else { continue
            }
            let hour = Calendar.current.component(.hour, from: departureDate)
            
            result.append(CarrierTrip(
                id: segment.thread?.uid ?? UUID().uuidString,
                carrierTitle: carrierTitle,
                carrierLogoURL: segment.thread?.carrier?.logo.flatMap(URL.init(string:)),
                dateText: CarrierListViewModel.dateFormatter.string(from: departureDate),
                departureTime: CarrierListViewModel.timeFormatter.string(from: departureDate),
                arrivalTime: formattedTime(from: arrival) ?? "",
                durationText: durationText(seconds: segment.duration),
                hasTransfer: false,
                transferCityTitle: nil,
                timeOfDay: .from(hour: hour)))
        }
        
        return result
    }
    
    func formattedTime(from iso: String) -> String? {
        guard let date = ISO8601DateFormatter().date(from: iso) else { return nil }
        return CarrierListViewModel.timeFormatter.string(from: date)
    }
    
    private func durationText(seconds: Int?) -> String {
        guard let seconds else { return "" }
        let hours = seconds / 3600
        return "\(hours) часов"
    }
    
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
}
