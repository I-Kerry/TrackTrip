import SwiftUI

struct MainScreen: View {
    @ObservedObject private var viewModel: ViewModel
    init() {
        self.viewModel = ViewModel()
    }
    var body: some View {
        TabView {
            VStack(spacing: 0) {
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
            
            .tabItem {
                Image(systemName: "arrow.up.message.fill")
            }
            Color.green
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
        }
        .foregroundStyle(.whiteBlack)
    }
}

#Preview {
    MainScreen()
}

