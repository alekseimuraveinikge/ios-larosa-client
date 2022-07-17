class RussianNumberFormatter: NumberFormatter {
	let countryCode: String = "+7"
	let numberLength: Int = 10
	
	func isNumberCompleted(_ number: String) -> Bool {
		digits(string: number).count > numberLength
	}
	
	func digits(string: String) -> String {
		string.replacingOccurrences(
			of: countryCode,
			with: ""
		)
		.components(separatedBy: .decimalDigits.inverted)
		.joined()
	}
	
	func format(string: String) -> String {
		let number = digits(string: string)
		let length = number.count
		
		let formatted: String
		
		switch length {
		case 0...2:
			formatted = number
		case 3:
			formatted = "(\(number))"
		default:
			let first = number.prefix(3)
			let index = number.index(number.startIndex, offsetBy: 3)
			let range = index..<number.endIndex
			let last = formatLast(String(number[range]))
			formatted = "(\(first)) \(last)"
		}
		
		return "\(countryCode) \(formatted)"
	}
	
	private func formatLast(_ string: String) -> String {
		switch string.count {
		case 0...4:
			return string
		default:
			let first = string.prefix(3)
			let index = string.index(string.startIndex, offsetBy: 3)
			let range = index..<string.endIndex
			let last = formatLast(String(string[range]))
			return "\(first)-\(last)"
		}
	}
}
