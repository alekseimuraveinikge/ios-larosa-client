import UIKit

class LoginView: UIView {
	@IBOutlet var backButton: UIButton!
	@IBOutlet var phoneTextField: UnderlineTextField!
	@IBOutlet var loginButton: GradientButton!
	@IBOutlet var bottomConstraint: NSLayoutConstraint!
	@IBOutlet var createAccount: UIButton!
	
	var allFieldsAreValid: Bool {
		phoneTextField.isValid
	}
}
