import Foundation

extension Date {
    func hour() -> Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: self)
    }
    
    func day() -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }
    
    func month() -> Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }
}
