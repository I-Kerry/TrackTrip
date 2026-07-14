import Foundation
import Combine

@MainActor

final class CarrierListViewModel: ObservableObject {
    @Published private(set) var trips: [CarrierTrip] = []
    @Published private(set) var isLoading: Bool = false
    @Published var error: AppError?
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
    
    func loadTrips() async {
        isLoading = true
        
        defer { isLoading = false }
        error = nil
        
        do {
            let response = try await scheduleService.getSchedualBetweenStations(from: fromStation.code, to: toStation.code, transfers: filters.showTransfers)
            trips = map(response)
        } catch {
            self.error = AppError.from(error)
        }
    }
    
    func applyFilters(_ newFilter: FilterOptions) async {
        filters = newFilter
        await loadTrips()
    }
    
    func map(_ response: ScheduleBetweenStations) -> [CarrierTrip] {
        var result: [CarrierTrip] = []
        
        guard let segments = response.segments else {
            return [] }
        
        for (index, segment) in segments.enumerated() {
            
            let carrierTitle = segment.thread?.carrier?.title.flatMap { $0.isEmpty ? nil : $0 }
            ?? segment.thread?.title
            ?? ""
            
            guard let departure = segment.departure else {
                continue
            }
            guard let arrival = segment.arrival else {
                continue
            }
            guard let departureDate = parseDate(from: departure) else {
                continue
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
    
    private func parseDate(from string: String) -> Date? {
        if let date = ISO8601DateFormatter().date(from: string) {
            return date
        }
        
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "en_US_POSIX")
        timeFormatter.dateFormat = "HH:mm:ss"
        
        if let timeDate = timeFormatter.date(from: string) {
            let current = Calendar.current
            let today = Date()
            var components = current.dateComponents([.hour, .minute, .second], from: timeDate)
            components.year = current.component(.year, from: today)
            components.month = current.component(.month, from: today)
            components.day = current.component(.day, from: today)
            return current.date(from: components)
        }
        
        return nil
    }
    
    func formattedTime(from iso: String) -> String? {
        guard let date = parseDate(from: iso) else {
            return nil
        }
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
