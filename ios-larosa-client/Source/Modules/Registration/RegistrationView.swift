import UIKit

class RegistrationView: UIView {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameTextField: UnderlineTextField!
    @IBOutlet weak var phoneTextField: UnderlineTextField!
    @IBOutlet weak var permissionSwitch: UISwitch!
    @IBOutlet weak var permissionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var registrationButton: GradientButton!
	@IBOutlet weak var logIn: UIButton!
	
	var allFieldsAreValid: Bool {
		nameTextField.isValid
			&& phoneTextField.isValid
			&& permissionSwitch.isOn
	}
}
