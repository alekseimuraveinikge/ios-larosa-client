import UIKit

extension Notification {
	var keyboardSize: CGSize? {
		userInfo?[UIResponder.keyboardFrameEndUserInfoKey].flatMap {
			($0 as? NSValue)?.cgRectValue.size
		}
	}
}
