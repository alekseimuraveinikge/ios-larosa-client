import UIKit

class LoginViewController: ViewController<LoginView, LoginPresenter> {
	override func viewDidLoad() {
		super.viewDidLoad()
        
		rootView.phoneTextField.delegate = self
		// TODO: Move to localization
		rootView.phoneTextField.validator = PhoneNumberValidator(
			formatter: RussianNumberFormatter(),
			errorMessage: "Введите номер телефона"
		)
		
		rootView.backButton.addTarget(
			self,
			action: #selector(didTapBack),
			for: .touchUpInside
		)
        
		rootView.loginButton.addTarget(
			self,
			action: #selector(didTapLogin),
			for: .touchUpInside
		)
		
		rootView.createAccount.addTarget(
			self,
			action: #selector(didTapCreateAccount),
			for: .touchUpInside
		)
        
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillShow),
			name: UIResponder.keyboardWillShowNotification,
			object: nil
		)
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillHide),
			name: UIResponder.keyboardWillHideNotification,
			object: nil
		)
		
		validateFields()
	}
}

// MARK: Private

extension LoginViewController {
	@objc
	func didTapBack() {
		presenter.backAction()
	}
	
	@objc
	func didTapCreateAccount() {
		presenter.registerAction()
	}
	
	@objc
	func didTapLogin() {
		if rootView.allFieldsAreValid {
			presenter.loginAction()
		} else {
			rootView.phoneTextField.validate()
		}
	}
	
	@objc
	func validateFields() {
		rootView.loginButton.alpha = rootView.allFieldsAreValid
			? buttonValidAlpha
			: buttonNotValidAlpha
	}
	
	@objc
	func keyboardWillShow(notification: Notification) {
		guard let keyboardSize = notification.keyboardSize else {
			return
		}
		
		UIView.animate(withDuration: keyboardAnimationDuration) { [rootView] in
			rootView.bottomConstraint.constant = keyboardSize.height
			rootView.layoutIfNeeded()
		}
	}

	@objc
	func keyboardWillHide(notification _: Notification) {
		UIView.animate(withDuration: keyboardAnimationDuration) { [rootView] in
			rootView.bottomConstraint.constant = .zero
			rootView.layoutIfNeeded()
		}
	}
}

// MARK: UnderlineTextFieldDelegate

extension LoginViewController: UnderlineTextFieldDelegate {
	func onValueChanged(field _: UnderlineTextField, value _: String?) {
		validateFields()
	}
	
	func onReturn(field: UnderlineTextField) {
		field.resignFirstResponder()
	}
}

// MARK: Layout constants

private let buttonNotValidAlpha: CGFloat = 0.5
private let buttonValidAlpha: CGFloat = 1.0

private let keyboardAnimationDuration: CGFloat = 1.0
