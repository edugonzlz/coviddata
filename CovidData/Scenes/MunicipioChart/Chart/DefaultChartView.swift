import SwiftUI
import Charts

struct DefaultChartView: UIViewRepresentable {
    
    @ObservedObject var viewModel: ChartViewModel

    func makeUIView(context: Context) -> LineChartView {
        return LineChartView()
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        var values = [ChartDataEntry]()
        viewModel.data.enumerated().forEach { index, day in
            let entry = ChartDataEntry(x: Double(index), y: Double(day.casos_confirmados_ultimos_14dias ?? 0))
            values.append(entry)
        }
        let dataSet = LineChartDataSet(entries: values, label: "Número de casos")
        dataSet.drawCirclesEnabled = false
        let data = LineChartData(dataSets: [dataSet])
        uiView.data = data
        uiView.chartDescription?.text = "Casos confirmados en los últimos 14 días"
        let xAxis = uiView.xAxis
        let xFormatter = ChartValueFormatter(data: viewModel.data)
        xAxis.valueFormatter = xFormatter
        uiView.notifyDataSetChanged()
    }
}

class ChartValueFormatter: NSObject, IAxisValueFormatter {

    fileprivate var data: [DailyData]?

    convenience init(data: [DailyData]) {
        self.init()
        self.data = data
    }
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let data = data else {
            return ""
        }
        return data[Int(value)].dia
    }
}
