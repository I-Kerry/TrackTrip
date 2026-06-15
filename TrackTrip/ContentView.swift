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
            testFetchCopyright()
            testCarrier()
            testFetchAllStation()
            testNearestCity()
            testScheduleAtStation()
            testScheduleBetweenStations()
            testThread()
        }
    }
    
//    MARK: testFetchStations
    
    func testFetchStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport())
                
                let service = NearestStationsService(
                    client: client,
                    apiKey: ApiKey.apikey)
                
                print("Fetching stations...")
                let stations = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50)
                print("Successfully fetched stations: \(stations)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    //MARK: testFetchCopyright
    
    func testFetchCopyright() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport())
                
                let server = CopyrightService(
                    client: client,
                    apiKey: "2fe73353-93c8-4a53-abc8-8db270c4bf8a")
                
                print("Fetching stations...")
                let copyright = try await server.getCopyright()
                print("Successfully fetched stations: \(copyright)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    //MARK: testFetchAllStation
    
    func testFetchAllStation() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport())
                
                let server = AllStationsService(apiKey: ApiKey.apikey,
                                                client: client)
                
                print("Fetching stations...")
                let allStations = try await server.getAllStations()
                print("Successfully fetched stations: \(allStations)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    //MARK: testCarrier
    
    func testCarrier() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport())
                
                let server = CarrierService(apiKey: ApiKey.apikey,
                                            client: client)
                
                print("Fetching Carrier...")
                let carrier = try await server.getCarrierInfo(code: "26")
                print("Successfully fetched Carrier: \(carrier)")
            } catch {
                print("Error fetching Carrier: \(error)")
            }
        }
    }
    
    //MARK: testNearestCity
    
    func testNearestCity() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport())
                
                let server = NearestCityService(apiKey: ApiKey.apikey,
                                                client: client)
                
                print("Fetching NearestCity...")
                let nearestCity = try await server.getNearestCity(
                    lat: 55.7558,
                    lng: 37.6173)
                print("Successfully fetched NearestCity: \(nearestCity)")
            } catch {
                print("Error fetching Carrier: \(error)")
            }
        }
    }
    
    //MARK: testScheduleAtStation
    
    func testScheduleAtStation() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport())
                
                let server = ScheduleAtStationService(client: client,
                                                      apiKey: ApiKey.apikey)
                
                print("Fetching ScheduleAtStation...")
                let scheduleAtStation = try await server.getStationSchedule(station: "s9600213")
                print("Successfully fetched ScheduleAtStation: \(scheduleAtStation)")
            } catch {
                print("Error fetching ScheduleAtStation: \(error)")
            }
        }
    }
    
    //MARK: testScheduleBetweenStations
    
    func testScheduleBetweenStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport())
                
                let server = ScheduleBetweenStationsService(
                    apiKey: ApiKey.apikey,
                    client: client)
                
                print("Fetching ScheduleBetweenStations...")
                let scheduleBetweenStations = try await server.getSchedualBetweenStations(from: "s9600396", to: "s9600213")
                print("Successfully fetched ScheduleBetweenStations: \(scheduleBetweenStations)")
            } catch {
                print("Error fetching ScheduleBetweenStations: \(error)")
            }
        }
    }
    
//    MARK: testThread
    
    func testThread() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport())
                
                let server = StationThreadService(
                    apiKey: ApiKey.apikey,
                    client: client)
                
                print("Fetching Thread...")
                let thread = try await server.getRouteStations(uid: "SU-424_261025_c26_12")
                print("Successfully fetched Thread: \(thread)")
            } catch {
                print("Error fetching Thread: \(error)")
            }
        }
    }
    
}

#Preview {
    ContentView()
}

