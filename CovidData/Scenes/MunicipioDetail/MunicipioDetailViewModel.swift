import Foundation
import SwiftUI

class MunicipioDetailViewModel: ObservableObject {
    
    @Published var municipio: Municipio

    init(municipio: Municipio) {
        self.municipio = municipio
    }
}
