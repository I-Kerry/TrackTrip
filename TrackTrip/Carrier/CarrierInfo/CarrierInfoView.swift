
import SwiftUI

struct CarrierInfoView: View {
    @StateObject private var viewModel: CarrierInfoViewModel
    
    init(carrierCode: Int) {
        _viewModel = StateObject(wrappedValue: CarrierInfoViewModel(carrierCode: carrierCode))
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.error {
                ErrorView(error: error) .task {
                    await viewModel.loadCarrier()
                }
            } else if let carrier = viewModel.carrier {
                content(for: carrier)
            }
        }
        .task {
            await viewModel.loadCarrier()
        }
        .navigationTitle("Информация о перевозчике").font(.system(size: 17, weight: .bold))
    }
    
    private func content(for carrier: Carrier) -> some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                if let logoURLString = carrier.logo,
                   let url = URL(string: logoURLString) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFit()
                    }  placeholder: {
                        ProgressView()
                    }
                    .frame(height: 104)
                    .frame(maxWidth: .infinity)
                }
                if let title = carrier.title {
                    Text(title)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.blackWhite)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            
            List {
                if let email = carrier.email, !email.isEmpty {
                    infoRow(title: "E-mail", value: email, url: URL(string: "\(email)"))
                }
                
                if let tel = carrier.phone, !tel.isEmpty {
                    infoRow(title: "Телефон", value: tel, url: URL(string: "\(tel.filter { $0.isNumber || $0 == "+" })"))
                }
            }
            .listStyle(.plain)
        }
    }
    
    
    private func infoRow(title: String, value: String, url: URL?) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.blackWhite)
            
            if let url {
                Link(value, destination: url)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.blue)
            } else {
                Text(value)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.blue)
            }
        }
    }
}
