import UIKit

class RegistrationViewController: ViewController<RegistrationView, RegistrationPresenter> {
	override func viewDidLoad() {
		super.viewDidLoad()
        
        rootView.nameTextField.delegate = self
        rootView.phoneTextField.delegate = self
		
		rootView.nameTextField.validator = NotEmptyValidator()
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
		
		rootView.registrationButton.addTarget(
			self,
			action: #selector(didTapRegistration),
			for: .touchUpInside
		)
		
		rootView.logIn.addTarget(
			self,
			action: #selector(didTapLogin),
			for: .touchUpInside
		)
		
		rootView.permissionSwitch.addTarget(
			self,
			action: #selector(validateFields),
			for: .valueChanged
		)
		
		validateFields()
    }
}


// MARK: Private
private extension RegistrationViewController {
	@objc
	func didTapBack() {
		presenter.backAction()
	}
	
	@objc
	func didTapLogin() {
		presenter.loginAction()
	}
	
	@objc
	func didTapRegistration() {
		if rootView.allFieldsAreValid {
			presenter.registerAction()
		} else {
			rootView.nameTextField.validate()
			rootView.phoneTextField.validate()
			
			if !rootView.permissionSwitch.isOn {
				switcherError()
			}
		}
	}
	
	@objc
	func validateFields() {
		rootView.registrationButton.alpha = rootView.allFieldsAreValid
		? buttonValidAlpha
		: buttonNotValidAlpha
	}
	
	func switcherError() {
		guard let permissionLabel = rootView.permissionLabel else { return }
		
		UIView.animate(
			withDuration: captionZoomInDuration,
			delay: .zero,
			options: .curveEaseOut
		) {
			permissionLabel.transform = captionZoomInTransform
		} completion: { _ in
			UIView.animate(
				withDuration: captionZoomOutDuration,
				delay: .zero,
				options: .curveEaseOut
			) {
				permissionLabel.transform = .identity
			}
		}
	}
}


// MARK: UnderlineTextFieldDelegate
extension RegistrationViewController: UnderlineTextFieldDelegate {
	func onValueChanged(field: UnderlineTextField, value: String?) {
		validateFields()
	}
	
    func onReturn(field: UnderlineTextField) {
        field.resignFirstResponder()
        if field == rootView.nameTextField, !rootView.phoneTextField.isValid {
			rootView.phoneTextField.becomeFirstResponder()
        }
    }
}


// MARK: Layout constants
private let buttonNotValidAlpha: CGFloat = 0.5
private let buttonValidAlpha: CGFloat = 1.0

private let captionZoomInDuration: CGFloat = 0.2
private let captionZoomOutDuration: CGFloat = 0.2

private let captionZoomInTransform = CGAffineTransform(scaleX: 1.05, y: 1.05)
