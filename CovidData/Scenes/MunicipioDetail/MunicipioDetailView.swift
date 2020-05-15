import Foundation
import SwiftUI

struct MunicipioDetailView: View {
    
    @ObservedObject var viewModel: MunicipioDetailViewModel
    @State var chartPresented = false

    var body: some View {
        NavigationView {
            List(viewModel.municipio.data) { (day: DailyData) in
                DayRow(dailyData: day)
            }
        }
        .navigationBarTitle(Text(viewModel.municipio.name.trimmingCharacters(in: .whitespaces)))
        .navigationBarItems(trailing:
            Button("Gráfico") { self.chartPresented.toggle() }
                .sheet(isPresented: $chartPresented) {
                    MunicipioChartView(viewModel: MunicipioChartViewModel(municipio: self.viewModel.municipio))
                }
        )
    }
}
