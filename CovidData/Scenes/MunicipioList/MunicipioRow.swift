import SwiftUI

struct MunicipioRow: View {
    
    var municipio: Municipio

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(municipio.name)
                Text(municipio.lastDate)
                    .font(Font.system(size: 10))
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("Total afectados: " + municipio.casosConfirmadosTotales)
                Text("Últimos 14 dias: " + municipio.casosConfirmadosUltimos14dias)
                }.multilineTextAlignment(.trailing)
                .font(Font.system(size: 12))
        }
    }
}
