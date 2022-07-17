protocol NumberFormatter {
	var countryCode: String { get }
	var numberLength: Int { get }
	
	func isNumberCompleted(_ number: String) -> Bool
	func digits(string: String) -> String
	func format(string: String) -> String
}
