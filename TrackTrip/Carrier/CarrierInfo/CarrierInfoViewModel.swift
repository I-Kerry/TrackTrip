
import Foundation
import Combine

@MainActor

final class CarrierInfoViewModel: ObservableObject {
    @Published private(set) var carrier: Carrier?
    @Published private(set) var isLoading: Bool = false
    @Published var error: AppError?
    
    let carrierCode: Int
    private let carrierService: CarrierProtocol
    
    init(carrierCode: Int, carrierService: CarrierProtocol = Services.carrier) {
        self.carrierCode = carrierCode
        self.carrierService = carrierService
    }
    
    func loadCarrier() async {
        isLoading = true
        
        defer { isLoading = false }
        error = nil
        
        do {
            carrier = try await carrierService.getCarrierInfo(code: String(carrierCode))
        } catch {
            self.error = AppError.from(error)
        }
    }
}
