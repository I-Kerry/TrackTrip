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
//            testFetchStations()
//            testFetchCopyright()
        }
    }
    
//    func testFetchStations() {
//        Task {
//            do {
//                let client = Client(
//                    serverURL: try Servers.Server1.url(),
//                    transport: URLSessionTransport())
//                
//                let service = NearestStationsService(
//                    client: client,
//                    apiKey: "2fe73353-93c8-4a53-abc8-8db270c4bf8a")
//                
//                print("Fetching stations...")
//                let stations = try await service.getNearestStations(
//                    lat: 59.864177,
//                    lng: 30.319163,
//                    distance: 50)
//                print("Successfully fetched stations: \(stations)")
//            } catch {
//                print("Error fetching stations: \(error)")
//            }
//        }
//    }
    
//    func testFetchCopyright() {
//        Task {
//            do {
//                let client = Client(
//                    serverURL: try Servers.Server1.url(),
//                    transport: URLSessionTransport())
//                
//                let server = CopyrightService(
//                    client: client,
//                    apiKey: "2fe73353-93c8-4a53-abc8-8db270c4bf8a")
//                
//                print("Fetching stations...")
//                let copyright = try await server.getCopyright()
//                print("Successfully fetched stations: \(copyright)")
//            } catch {
//                print("Error fetching stations: \(error)")
//            }
//        }
//    }
}

#Preview {
    ContentView()
}

