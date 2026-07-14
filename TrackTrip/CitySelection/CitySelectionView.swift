

import SwiftUI

struct CitySelectionView: View {
    let field: CityField
    
    var onSelect: (City) -> Void
    
    @StateObject private var viewModel = CitySelectionViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(searchText: $viewModel.searchText, placeholder: "Введите запрос")
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.error {
                ErrorView(error: error)
                
            } else if viewModel.filteredCities.isEmpty {
                Text("Город не найден")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.blackWhite)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(viewModel.filteredCities) { city in
                    Button {
                        onSelect(city)
                    } label: {
                        HStack {
                            Text(city.name)
                                .foregroundStyle(.blackWhite)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color.blackWhite)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Выбор города")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            try? await viewModel.loadCities()
        }
    }
}

#Preview {
    CitySelectionView(field: .from, onSelect: {_ in })
}
