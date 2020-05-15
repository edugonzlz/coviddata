import SwiftUI

struct DayRow: View {
    
    var dailyData: DailyData
    
    var body: some View {
        HStack {
            Text(dailyData.dia)
            Spacer()
            VStack(alignment: .trailing) {
                Text("Total afectados: \(dailyData.casosConfirmadosTotales)")
                Text("Últimos 14 dias: \(dailyData.casosConfirmadosUltimos14dias)")
            }
            .font(Font.system(size: 12))
        }
    }
}
