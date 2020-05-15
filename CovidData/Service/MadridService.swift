import Foundation

class MadridService {
    
    // MARK: - Public
    static let shared = MadridService()
    enum MunicipioOrder: String {
        case name
        case totalCases
    }
    
    // MARK: - Private
    private let rm = RequestManager()
    
    private let dataUrl = "https://datos.comunidad.madrid/catalogo/dataset/7da43feb-8d4d-47e0-abd5-3d022d29d09e/resource/ead67556-7e7d-45ee-9ae5-68765e1ebf7a/download/covid19_tia_muni_y_distritos.json"
    private let localDataName = "madrid_data"
    private var allData = [DailyData]()
    
    // MARK: - init
    private init() {}
    
    // MARK: - get data
    func getData(completion: @escaping (Result<[DailyData], Error>) -> Void) {
        if let localData = Storage.retrieve(localDataName, from: .documents, as: [DailyData].self) {
            if let lastDate = localData.first?.fecha, needRefresh(lastDate: lastDate) {
                getRemoteData(completion: completion)
            } else {
                self.allData = localData
                completion(.success(localData))
            }
        } else {
            getRemoteData(completion: completion)
        }
    }
    
    // TODO: - entregar desde base de datos
    func getMunicipios(by order: MunicipioOrder = .name) -> [Municipio] {
        let municipios = getMunicipios()
        switch order {
        case .name:
            return municipios.sorted{$0.name < $1.name}
        case .totalCases:
            return municipios.sorted{$0.data.first?.casos_confirmados_totales ?? 0 > $1.data.first?.casos_confirmados_totales ?? 0}
        }
    }
    
    func get(municipio: String) -> Municipio {
        let result = allData.filter({$0.municipio_distrito?.trimmingCharacters(in: .whitespaces).lowercased()
            == municipio.trimmingCharacters(in: .whitespaces).lowercased()})
        let municipio = Municipio(data: result)
        return municipio
    }
}

private extension MadridService {
    func getRemoteData(completion: @escaping (Result<[DailyData], Error>) -> Void) {
        guard let url = URL(string: dataUrl) else {
            return completion(.failure(LocalError.unknown))
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        rm.get(request: request) { result in
            switch result {
            case .success(let data):
                guard let allData = try? JSONDecoder().decode(MadridData.self, from: data) else {
                    return completion(.failure(LocalError.unknown))
                }
                self.allData = allData.data
                Storage.store(allData.data, to: .documents, as: self.localDataName)
                completion(.success(allData.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMunicipios() -> [Municipio] {
        var municipios = [Municipio]()
        var elements = Set<String>()
        allData.forEach({elements.insert($0.codigo_geometria?.trimmingCharacters(in: .whitespaces) ?? "")})
        elements.forEach { codigo in
            let data = allData.filter({$0.codigo_geometria?.trimmingCharacters(in: .whitespaces) == codigo})
            let municipio = Municipio(data: data)
            municipios.append(municipio)
        }
        return municipios
    }
    
    func needRefresh(lastDate: Date) -> Bool {
         let now = Date()
         //si es de otro dia, refrescar
         if lastDate.day() != now.day() {
             return true
         }
         //mismo dia, pasadas las 10, no refrescar
         if now.hour() > lastDate.hour() {
             return false
         }
         return true
     }
}
