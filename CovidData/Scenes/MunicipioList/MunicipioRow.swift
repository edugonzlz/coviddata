import SwiftUI

struct MunicipioRow: View {
    
    var municipio: Municipio

    var body: some View {
        HStack {
            VStack {
                Text(municipio.name)
                Text(municipio.lastDate)
                    .font(Font.system(size: 10))
            }.multilineTextAlignment(.leading)
            
            Spacer()
            
            VStack {
                Text("Total afectados: " + municipio.casosConfirmadosTotales)
                Text("Últimos 14 dias: " + municipio.casosConfirmadosUltimos14dias)
                }.multilineTextAlignment(.trailing)
                .font(Font.system(size: 12))
        }
    }
}
