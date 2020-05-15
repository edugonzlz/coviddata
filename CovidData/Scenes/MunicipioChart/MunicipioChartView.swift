import SwiftUI

struct MunicipioChartView: View {
    
    @ObservedObject var viewModel: MunicipioChartViewModel
    
    var body: some View {
        NavigationView {
            DefaultChartView(viewModel: ChartViewModel(data: self.viewModel.municipio.data))
        }
        .navigationBarTitle(Text(viewModel.municipio.name.trimmingCharacters(in: .whitespaces)))
    }
}

