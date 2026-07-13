

import SwiftUI
struct CarrierListView: View {
    
    @StateObject private var viewModel: CarrierListViewModel
    @State private var isShowingFilters: Bool = false
    
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
            } else if let errorMessage = viewModel.errorMessage{
                Text(errorMessage)
                    .foregroundStyle(.blackWhite)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.filteredTrips) { trip in
                            CarrierListCell(trip: trip)
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
        .navigationTitle("\(fromTitle) → \(toTitle)")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadTrips()
        }
//        .sheet(isPresented: $isShowingFilters) {
//            FilterView(filters: viewModel.filters) { filter in
//                Task {
//                    await viewModel.applyFilters(filter)
//                }
//            }
//        }
        .navigationDestination(isPresented: $isShowingFilters) {
            FilterView(filters: viewModel.filters) { filter in
                Task {
                    await viewModel.applyFilters(filter)
                }
            }
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
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

#Preview {
    CarrierListView(fromStation: Station(id: "k", title: "Moscow", code: "1"), toStation: Station(id: "l", title: "Irkutsk", code: "2"), fromTitle: "Moscow", toTitle: "Irkutsk")
}
