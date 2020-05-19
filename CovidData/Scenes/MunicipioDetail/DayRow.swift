import SwiftUI

struct DayRow: View {
    
    var dailyData: DailyData
    
    var body: some View {
        HStack {
            Text(dailyData.diaMes)
            Spacer()
            VStack(alignment: .trailing) {
                Text("Total afectados: \(dailyData.casosConfirmadosTotales)")
                Text("Tasa de incidencia: \(dailyData.tasaIncidenciaAcumuladaTotal)")
                Text("Últimos 14 dias: \(dailyData.casosConfirmadosUltimos14dias)")
                Text("Tasa últimos 14 dias: \(dailyData.tasaIncidenciaAcumuladaUltimos14dias)")
            }
            .font(Font.system(size: 12))
        }
    }
}
