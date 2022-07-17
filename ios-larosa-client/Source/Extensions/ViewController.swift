import UIKit

class ViewController<ViewClass: UIView, Presenter>: UIViewController {
	let presenter: Presenter
	var rootView: ViewClass { view as! ViewClass }
	
	init(presenter: Presenter) {
		self.presenter = presenter
		super.init(nibName: String(describing: ViewClass.self), bundle: nil)
		hideKeyboardWhenTappedAround()
	}
	
	@available(*, unavailable)
	required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func hideKeyboardWhenTappedAround() {
		let tap = UITapGestureRecognizer(
			target: self,
			action: #selector(dismissKeyboard)
		)
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
	
	@objc private func dismissKeyboard() {
		view.endEditing(true)
	}
}
