protocol Validator {
	var errorMessage: String { get }
	func isValid(text: String?) -> Bool
}

extension Optional where Wrapped == Validator {
	func isValid(_ text: String?) -> Bool {
		if case let .some(validator) = self {
			return validator.isValid(text: text)
		}
		return true
	}
}
