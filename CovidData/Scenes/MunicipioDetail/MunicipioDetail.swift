import Foundation
import SwiftUI

struct MunicipioDetail: View {
    
    @ObservedObject var viewModel: MunicipioDetailViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.municipio.data) { (day: DailyData) in
                DayRow(dailyData: day)
            }
        }
        .navigationBarTitle(Text(viewModel.municipio.name.trimmingCharacters(in: .whitespaces)))

    }
    
}
