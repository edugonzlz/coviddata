import SwiftUI

class ChartViewModel: ObservableObject {
    
    @Published var data: [DailyData]

    init(data: [DailyData]) {
        self.data = data.reversed()
    }
}
