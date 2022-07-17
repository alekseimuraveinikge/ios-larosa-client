class PhoneNumberValidator: Validator {
	let formatter: NumberFormatter
	let errorMessage: String
	
	init(formatter: NumberFormatter, errorMessage: String) {
		self.formatter = formatter
		self.errorMessage = errorMessage
	}
	
	func isValid(text: String?) -> Bool {
		guard let text = text else { return false }
		return formatter.digits(string: text).count == formatter.numberLength
	}
}
