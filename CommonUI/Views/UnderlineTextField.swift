import UIKit

protocol UnderlineTextFieldDelegate: AnyObject {
	func onValueChanged(field: UnderlineTextField, value: String?)
    func onReturn(field: UnderlineTextField)
}

class UnderlineTextField: UIView {
	enum `Type`: String {
		case text
		case phone
	}
	
	@IBInspectable var placeholder: String = "" {
		didSet {
			textField.attributedPlaceholder = placeholder.attributedWith(color: .paleBlue)
		}
	}
	@IBInspectable var type: String = `Type`.text.rawValue {
		didSet {
			configureTextField()
		}
	}
	
	private var fieldType: `Type` {
		Type(rawValue: type) ?? .text
	}
        
    private let textField: UITextField = {
		let textField = UITextField()
		textField.font = .gothamPro(.medium, size: .large)
		textField.textColor = UIColor.lightBlue
		textField.contentVerticalAlignment = .bottom
		textField.rightView = UIImageView(image: UIImage.done)
		textField.rightViewMode = .always
		textField.rightView?.isHidden = true
		return textField
    }()
	
	private let underlineView: UIView = {
		let underlineView = UIView()
		underlineView.backgroundColor = .paleBlue
		return underlineView
	}()
	
	private let errorLabel: UILabel = {
		let errorLabel = UILabel()
		errorLabel.font = .gothamPro(.regular, size: .small)
		errorLabel.textColor = UIColor.errorColor
		return errorLabel
	}()
	
	weak var delegate: UnderlineTextFieldDelegate?
	var validator: Validator?
	
	private var observation: NSKeyValueObservation?
	private var numberFormatter: NumberFormatter? {
		(validator as? PhoneNumberValidator)?.formatter
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupLayout()
		
		textField.delegate = self
		
		observation = textField.observe(\.text, options: .new) { [unowned self] _, value in
			guard let newValue = value.newValue else { return }
			self.handleNewValue(newValue)
		}
	}
	
	@discardableResult
	override func resignFirstResponder() -> Bool {
		textField.resignFirstResponder()
	}
	
	@discardableResult
	override func becomeFirstResponder() -> Bool {
		textField.becomeFirstResponder()
	}
	
	private func setupLayout() {
		[
			textField,
			underlineView,
			errorLabel
		]
		.forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}
		
		NSLayoutConstraint.activate([
			textField.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
			textField.leadingAnchor.constraint(equalTo: leadingAnchor),
			textField.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			underlineView.topAnchor.constraint(
				equalTo: textField.bottomAnchor,
				constant: textTextFieldLineSpacing
			),
			underlineView.leadingAnchor.constraint(equalTo: leadingAnchor),
			underlineView.trailingAnchor.constraint(equalTo: trailingAnchor),
			underlineView.heightAnchor.constraint(equalToConstant: lineHeight),
			
			errorLabel.topAnchor.constraint(equalTo: underlineView.bottomAnchor),
			errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			errorLabel.heightAnchor.constraint(equalToConstant: labelHeight),
			errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
	}
	
	private func configureTextField() {
		textField.textColor = .lightBlue
		switch fieldType {
		case .text:
			textField.keyboardType = .default
			textField.autocapitalizationType = .words
		case .phone:
			textField.keyboardType = .phonePad
			let toolbar: UIToolbar = UIToolbar()
			toolbar.barStyle = .default
			toolbar.items = [
				UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
				UIBarButtonItem(
					// TODO: Move to localization
					title: "Готово",
					style: .done,
					target: self,
					action: #selector(doneTapped)
				)
			]
			toolbar.sizeToFit()
			toolbar.tintColor = UIColor.lightBlue
			textField.inputAccessoryView = toolbar
		}
	}
}


// MARK: Public
extension UnderlineTextField {
	var isValid: Bool { validator.isValid(textField.text) }
	
	func validate() {
		guard !isValid else { return }
		
		errorLabel.isHidden = false
		errorLabel.text = validator?.errorMessage
		textField.textColor = .errorColor
		textField.attributedPlaceholder = placeholder.attributedWith(color: .errorColor)
		textField.rightView = UIImageView(image: UIImage.error)
		textField.rightViewMode = .always
		underlineView.backgroundColor = .errorColor
	}
}


// MARK: - Private
private extension UnderlineTextField {
	func handleNewValue(_ value: String?) {
		let isValid = validator.isValid(value)
		underlineView.backgroundColor = isValid
			? UIColor.lightBlue
			: UIColor.paleBlue
		textField.rightView?.isHidden = !isValid

		if fieldType == .phone, isValid {
			delegate?.onReturn(field: self)
		}

		hideError()
		delegate?.onValueChanged(field: self, value: value)
	}
	
	func hideError() {
		errorLabel.isHidden = true
		errorLabel.text = nil
		textField.textColor = .lightBlue
		textField.attributedPlaceholder = placeholder.attributedWith(color: .paleBlue)
		textField.rightView = UIImageView(image: UIImage.done)
		textField.rightViewMode = .always
		textField.rightView?.isHidden = !isValid
	}
    
    @objc func doneTapped() {
        textField.resignFirstResponder()
    }
}


// MARK: UITextFieldDelegate
extension UnderlineTextField: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		delegate?.onReturn(field: self)
		return true
	}
	
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		if let numberFormatter = numberFormatter, fieldType == .phone, textField.text?.isEmpty == true {
			textField.text = "\(numberFormatter.countryCode) "
			hideError()
			underlineView.backgroundColor = .paleBlue
		}
		
		return true
	}
	
	func textField(
		_ textField: UITextField,
		shouldChangeCharactersIn range: NSRange,
		replacementString string: String
	) -> Bool {
		guard let currentText = textField.text,
			  let nsCurrentText = currentText as NSString?
		else { return true }
		
		var newText = String(nsCurrentText.replacingCharacters(in: range, with: string))
		
		if fieldType == .text {
			textField.text = newText
			return false
		}
				
		if string.isEmpty, currentText.last == ")" {
			newText.removeLast()
		}
		
		guard let numberFormatter = numberFormatter, !numberFormatter.isNumberCompleted(newText)
		else { return false }
		
		textField.text = numberFormatter.format(string: newText)
		
		return false
	}
}


// MARK: Layout constants
private let textTextFieldLineSpacing: CGFloat = 4.0
private let lineHeight: CGFloat = 2.0
private let labelHeight: CGFloat = 10.0
