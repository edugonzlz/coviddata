import Foundation

class MadridService {
    
    static let shared = MadridService()
    
    private init() {}
    private let dataUrl = "https://datos.comunidad.madrid/catalogo/dataset/7da43feb-8d4d-47e0-abd5-3d022d29d09e/resource/ead67556-7e7d-45ee-9ae5-68765e1ebf7a/download/covid19_tia_muni_y_distritos.json"
    let rm = RequestManager()

    private var allData = [DailyData]()
    
    func getData(completion: @escaping (Result<[DailyData], Error>) -> Void) {
        guard let url = URL(string: dataUrl) else {
            return completion(.failure(LocalError.unknown))
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        rm.get(request: request) { result in
            switch result {
            case .success(let data):
                if let allData = try? JSONDecoder().decode(MadridData.self, from: data) {
                    self.allData = allData.data
                    completion(.success(allData.data))
                } else {
                    completion(.success([]))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    enum MunicipioOrder: String {
        case name
        case totalCases
    }
    
    func getMunicipios(by order: MunicipioOrder) -> [Municipio] {
        var municipios = [Municipio]()
        var elements = Set<String>()
        allData.forEach({elements.insert($0.codigo_geometria?.trimmingCharacters(in: .whitespaces) ?? "")})
        elements.forEach { codigo in
            let data = allData.filter({$0.codigo_geometria?.trimmingCharacters(in: .whitespaces) == codigo})
            let municipio = Municipio(data: data)
            municipios.append(municipio)
        }
        
        switch order {

        case .name:
            return municipios.sorted{$0.name < $1.name}
        case .totalCases:
            return municipios.sorted{$0.data.first?.casos_confirmados_totales ?? 0 > $1.data.first?.casos_confirmados_totales ?? 0}
        }
    }
    
    func getData(municipio: String) -> Municipio {
        let result = allData.filter({$0.municipio_distrito?.trimmingCharacters(in: .whitespaces).lowercased()
            == municipio.trimmingCharacters(in: .whitespaces).lowercased()})
        let municipio = Municipio(data: result)
        return municipio
    }
}
