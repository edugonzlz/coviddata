import Foundation

struct Municipio: Codable, Hashable, Identifiable {
    
    var data: [DailyData]
    
    var name: String {
        return data.first?.municipio_distrito ?? "-"
    }
    var lastDate: String {
        return data.first?.diaMes ?? "-"
    }
    var tasaIncidenciaAcumuladaUltimos14dias: String {
        return data.first?.tasaIncidenciaAcumuladaUltimos14dias ?? "-"
    }
    var tasaIncidenciaAcumuladaTotal: String {
        return data.first?.tasaIncidenciaAcumuladaTotal ?? "-"
    }
    var casosConfirmadosTotales: String {
        return data.first?.casosConfirmadosTotales ?? "-"
    }
    var casosConfirmadosUltimos14dias: String {
        return data.first?.casosConfirmadosUltimos14dias ?? "-"
    }
    
    //Identifiable
    var id: String {
        return name
    }
    //Equatable
    static func == (lhs: Municipio, rhs: Municipio) -> Bool {
        return lhs.name == rhs.name
    }
}

