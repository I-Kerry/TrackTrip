import SwiftUI

struct StationSelectionView: View {
    var field: CityField
    let city: City
    var onSelect: (Station) -> Void
    
    @State private var searchText: String = ""
    
    private var filteredStations: [Station] {
        guard !searchText.isEmpty else { return city.station }
        return city.station.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(searchText: $searchText, placeholder: "Введите запрос")
            
            if filteredStations.isEmpty {
                Text("Станция не найдена")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.blackWhite)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(filteredStations) { station in
                    Button {
                        onSelect(station)
                    } label: {
                        HStack {
                            Text(station.title)
                                .foregroundStyle(.blackWhite)
                            Spacer()
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
    }
}
