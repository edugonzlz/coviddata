import Foundation

struct DailyData: Codable, Hashable, Identifiable {
    
    let municipio_distrito: String?
    let codigo_geometria: String?
    let tasa_incidencia_acumulada_ultimos_14dias: Double?
    let tasa_incidencia_acumulada_total: Double?
    let casos_confirmados_totales: Int?
    let casos_confirmados_ultimos_14dias: Int?
    let fecha_informe: String? // "2020/05/13 09:00:00"

    enum CodingKeys: String, CodingKey {
        case municipio_distrito
        case codigo_geometria
        case tasa_incidencia_acumulada_ultimos_14dias
        case tasa_incidencia_acumulada_total
        case casos_confirmados_totales
        case casos_confirmados_ultimos_14dias
        case fecha_informe
    }
    
    var fecha: Date? {
        guard let fecha_informe = fecha_informe else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        formatter.locale = Locale.current
        return formatter.date(from: fecha_informe)
    }
    
    var diaMes: String {
        guard let fecha = fecha else { return "-" }
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        formatter.locale = Locale.init(identifier: "es")
        return formatter.string(from: fecha)
    }

    var description: String {
        return """
        fecha_informe: \(fecha_informe ?? "")
        casos_confirmados_ultimos_14dias: \(casos_confirmados_ultimos_14dias ?? 0)
        casos_confirmados_totales: \(casos_confirmados_totales ?? 0)
        ******
        """
    }
    
    //Identifiable
    var id: String {
        return fecha_informe ?? ""
    }
    //Equatable
    static func == (lhs: DailyData, rhs: DailyData) -> Bool {
        return lhs.fecha == rhs.fecha
    }
    
    var tasaIncidenciaAcumuladaUltimos14dias: String {
        guard let data = tasa_incidencia_acumulada_ultimos_14dias else {
            return "-"
        }
        return String(data)
    }
    var tasaIncidenciaAcumuladaTotal: String {
        guard let data = tasa_incidencia_acumulada_total else {
            return "-"
        }
        return String(data)
    }
    var casosConfirmadosTotales: String {
        guard let data = casos_confirmados_totales else {
            return "-"
        }
        return String(data)
    }
    var casosConfirmadosUltimos14dias: String {
        guard let data = casos_confirmados_ultimos_14dias else {
            return "-"
        }
        return String(data)
    }
}
