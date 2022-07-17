import UIKit

class RegistrationView: UIView {
	@IBOutlet var backButton: UIButton!
	@IBOutlet var nameTextField: UnderlineTextField!
	@IBOutlet var phoneTextField: UnderlineTextField!
	@IBOutlet var permissionSwitch: UISwitch!
	@IBOutlet var permissionLabel: UILabel!
	@IBOutlet var scrollView: UIScrollView!
	@IBOutlet var registrationButton: GradientButton!
	@IBOutlet var logIn: UIButton!
	
	var allFieldsAreValid: Bool {
		nameTextField.isValid
			&& phoneTextField.isValid
			&& permissionSwitch.isOn
	}
}
