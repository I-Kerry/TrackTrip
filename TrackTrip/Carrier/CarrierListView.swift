

import SwiftUI
struct CarrierListView: View {
    
    @StateObject private var viewModel: CarrierListViewModel
    @State private var isShowingFilters: Bool = false
    @State private var selectedCarrierCode: Int?
    
    let fromTitle: String
    let toTitle: String
    
    init(fromStation: Station, toStation: Station, fromTitle: String, toTitle: String) {
        _viewModel = StateObject(wrappedValue: CarrierListViewModel(fromStation: fromStation, toStation: toStation))
        self.fromTitle = fromTitle
        self.toTitle = toTitle
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.error {
                ErrorView(error: error)

            } else if viewModel.filteredTrips.isEmpty {
                Text(ErrorString.noVariants)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.blackWhite)
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        Text("\(fromTitle) → \(toTitle)")
                            .font(.system(size: 24, weight: .bold))
                            .frame(alignment: .leading)
                            .foregroundStyle(Color.blackWhite)
                            .padding(16)
                        ForEach(viewModel.filteredTrips) { trip in
                            Button {
                                selectedCarrierCode = trip.carrierCode
                            } label: {
                                CarrierListCell(trip: trip)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(16)
                    .padding(.bottom, 80)
                }
            }
        }
        .overlay(alignment: .bottom) {
            refineTimeButton
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadTrips()
        }

        .navigationDestination(isPresented: $isShowingFilters) {
            FilterView(filters: viewModel.filters) { filter in
                Task {
                    await viewModel.applyFilters(filter)
                }
            }
        }
        
        .navigationDestination(item: $selectedCarrierCode) { code in
            CarrierInfoView(carrierCode: code)
        }
    }
    
    private var refineTimeButton: some View {
        Button {
            isShowingFilters = true
        } label: {
            HStack {
                Text("Уточнить время")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.white)
                if viewModel.filters.isActive {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .padding([.horizontal, .bottom], 16)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    CarrierListView(fromStation: Station(id: "k", title: "Moscow", code: "1"), toStation: Station(id: "l", title: "Irkutsk", code: "2"), fromTitle: "Moscow", toTitle: "Irkutsk")
}
