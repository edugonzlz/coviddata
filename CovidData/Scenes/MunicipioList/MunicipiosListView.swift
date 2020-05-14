import SwiftUI

struct MunicipiosListView: View {

    @ObservedObject var viewModel: MunicipiosListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.data) { municipio in
                NavigationLink(destination: MunicipioDetail(viewModel: MunicipioDetailViewModel(municipio: municipio))) {
                    MunicipioRow(municipio: municipio)
                }
            }
            .navigationBarTitle(Text("Municipios"))
            .navigationBarItems(trailing:
                HStack {
                    Toggle(isOn: $viewModel.orderByTotalCases) {
                        Text("Ordenar por total")
                    }
                }
            )
            .onAppear {
                self.viewModel.getData()
            }
            
        }
    }
}
