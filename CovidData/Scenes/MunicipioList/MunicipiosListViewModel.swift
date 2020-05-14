import Foundation
import SwiftUI

class MunicipiosListViewModel: ObservableObject {
    
    let service = MadridService.shared

    @Published private (set) var data: [Municipio] = []
    
    func getData() {
        guard data.isEmpty else { return }
        service.getData { result in
            let data = MadridService.shared.getMunicipios(by: .totalCases)
            DispatchQueue.main.async { [weak self] in
                self?.data = data
            }
        }
    }
    
    func get(municipio: String) -> Municipio {
        service.getData(municipio: municipio)
    }
}
