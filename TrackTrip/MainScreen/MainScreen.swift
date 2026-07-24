import SwiftUI

struct MainScreen: View {
    @ObservedObject private var viewModel: ViewModel
    
    @ObservedObject private var settingViewModel: SettingsViewModel
    
    init() {
        self.viewModel = ViewModel()
        self.settingViewModel = SettingsViewModel()
    }
    
    var body: some View {
        TabView {
            NavigationStack(path: $viewModel.path) {
                VStack {
                    StoriesListView()
                        .padding(.top, 24)
                        .padding(.bottom, 20)
                    
                    RouteCard(
                        fromText: viewModel.fromCity,
                        toText: viewModel.toCity,
                        swap: viewModel.SwapCities,
                        chooseCityFrom: viewModel.selectFrom,
                        chooseCityTo: viewModel.selectTo
                    )
                    .padding(.top, 16)
                    
                    if viewModel.isSearchShown {
                        SearchButton(
                            action: viewModel.search
                        )
                        .padding(.top, 16)
                    }
                    
                    Spacer()
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .citySelection(let field):
                        CitySelectionView(field: field) { city in
                            viewModel.didSelectCity(for: field, city)
                        }
                    case .stationSelection(let field, let city):
                        StationSelectionView(field: field, city: city) { station in
                            viewModel.didSelectStation(for: field, in: city, station)
                        }
                    case .carrierList(let fromStation, let toStation, let fromTitle, let toTitle):
                        CarrierListView(fromStation: fromStation, toStation: toStation, fromTitle: fromTitle, toTitle: toTitle)
                    }
                }
        }
            
            .tabItem {
                Image(systemName: "arrow.up.message.fill")
            }
            SettingsView(viewModel: settingViewModel)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
        }
    }
}

#Preview {
    MainScreen()
}

