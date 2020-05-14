import Foundation

let dailyDummy = DailyData(municipio_distrito: "Colmenar Dummy", codigo_geometria: "1234", tasa_incidencia_acumulada_ultimos_14dias: 13, tasa_incidencia_acumulada_total: 122, casos_confirmados_totales: 456, casos_confirmados_ultimos_14dias: 4, fecha_informe: "2020/05/13 09:00:00")

let municipioDummy = Municipio(data: [dailyDummy, dailyDummy])
let municipioDummy2 = Municipio(data: [dailyDummy, dailyDummy])
