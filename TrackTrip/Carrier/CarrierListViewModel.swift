import Foundation
import Combine

@MainActor

final class CarrierListViewModel: ObservableObject {
    @Published private(set) var trips: [CarrierTrip] = []
    @Published private(set) var isLoading: Bool = false
    @Published var error: AppError?
    @Published var filters: FilterOptions = .empty
    @Published var selectedDate: Date = Date()

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
            let response = try await scheduleService.getScheduleBetweenStations(from: fromStation.code, to: toStation.code, date: selectedDate, transfers: filters.showTransfers ?? true)
            print("total:", response.pagination?.total ?? -1, "segments:", response.segments?.count ?? -1)
            trips = map(response)
            print("mapped trips:", trips.count)
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
        
        for (_, segment) in segments.enumerated() {
            
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
                carrierCode: segment.thread?.carrier?.code,
                carrierLogoURL: logoURL(from: segment.thread?.carrier?.logo),
                dateText: CarrierListViewModel.dateFormatter.string(from: departureDate),
                departureTime: CarrierListViewModel.timeFormatter.string(from: departureDate),
                arrivalTime: formattedTime(from: arrival) ?? "",
                durationText: durationText(seconds: segment.duration),
                hasTransfer: segment.has_transfers ?? false,
                transferCityTitle: nil,
                timeOfDay: .from(hour: hour)))
        }
        return result
    }
    
    private func logoURL(from string: String?) -> URL? {
        guard let string,
              string.isEmpty else { return nil }
        if string.hasPrefix("//") {
            return URL(string: "https:" + string)
        }
        return URL(string: string)
    }
    
    private func parseDate(from string: String) -> Date? {
        if let date = ISO8601DateFormatter().date(from: string) {
            return date
        }
        
        let formats = ["yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd'T'HH:mm:ss"]
        
        for _ in formats {
            let timeFormatter = DateFormatter()
            timeFormatter.locale = Locale(identifier: "en_US_POSIX")
            timeFormatter.dateFormat = "HH:mm:ss"
            if let date = timeFormatter.date(from: string) {
                return date
            }
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
