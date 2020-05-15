import Foundation

class MunicipioChartViewModel: ObservableObject {
    
    @Published var municipio: Municipio
    
    init(municipio: Municipio) {
        self.municipio = municipio
    }

}
