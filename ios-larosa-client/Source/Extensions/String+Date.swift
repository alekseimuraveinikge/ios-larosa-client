import Foundation

extension String {
    var ddMMyyyyDate: Date {
        formatter.date(from: self) ?? Date()
    }
}

extension Date {
	var ddMMyyyy: String {
		formatter.string(from: self)
	}
}

private let formatter: DateFormatter = {
	let formatter = DateFormatter()
	formatter.dateFormat = "dd.MM.yyyy"
	return formatter
}()
