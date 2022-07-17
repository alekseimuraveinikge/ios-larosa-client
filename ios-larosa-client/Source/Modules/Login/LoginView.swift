import UIKit

class LoginView: UIView {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var phoneTextField: UnderlineTextField!
    @IBOutlet weak var loginButton: GradientButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
	@IBOutlet weak var createAccount: UIButton!
	
	var allFieldsAreValid: Bool {
		phoneTextField.isValid
	}
}
