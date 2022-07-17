class NotEmptyValidator: Validator {
	let errorMessage = "Заполните поле"
	
	func isValid(text: String?) -> Bool {
		guard let text = text else {
			return false
		}
		return !text.isEmpty
	}
}
