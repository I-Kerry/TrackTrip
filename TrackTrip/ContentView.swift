import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            testFetchStations()
        }
    }
    
//    MARK: testFetchStations
    
    func testFetchStations() {
        Task {
            do {
                let manager = try YandexScheduleManager(apiKey: ApiKey.apikey)
                let stations = try await manager.testFetchStations()
                let copyright = try await manager.testFetchCopyright()
                let allStations = try await manager.testFetchAllStation()
                let nearestCity = try await manager.testNearestCity()
                let carrier = try await manager.testCarrier()
                let scheduleAtStation = try await manager.testScheduleAtStation()
                let scheduleBetweenStations = try await manager.testScheduleBetweenStations()
                let thread = try await manager.testThread()
                print("Successfully fetched Thread: \(thread)")
                print("Successfully fetched ScheduleBetweenStations: \(scheduleBetweenStations)")
                print("Successfully fetched ScheduleAtStation: \(scheduleAtStation)")
                print("Successfully fetched Carrier: \(carrier)")
                print("Successfully fetched NearestCity: \(nearestCity)")
                print("Successfully fetched allStations: \(allStations)")
                print("Successfully fetched NearestStations: \(stations)")
                print("Successfully fetched copyright: \(copyright)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}

