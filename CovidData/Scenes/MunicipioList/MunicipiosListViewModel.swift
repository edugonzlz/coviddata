import Foundation
import SwiftUI

class MunicipiosListViewModel: ObservableObject {
    
    let service = MadridService.shared
    
    @Published private (set) var data: [Municipio] = []
    @Published var orderByTotalCases: Bool = false {
        willSet {
            getMunicipios(orderByTotalCases: newValue)
        }
    }
    
    func getData() {
        guard data.isEmpty else {  return }
        service.getData { [weak self] result in
            self?.getMunicipios(orderByTotalCases: false)
        }
    }
    
    func getMunicipios(orderByTotalCases: Bool) {
        let data = self.service.getMunicipios(by: orderByTotalCases ? .totalCases : .name)
        DispatchQueue.main.async { [weak self] in
            self?.data = data
        }
    }
    
    func get(municipio: String) -> Municipio {
        service.getData(municipio: municipio)
    }
}
