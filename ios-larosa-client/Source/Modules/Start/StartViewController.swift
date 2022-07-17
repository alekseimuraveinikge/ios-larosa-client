import UIKit

class StartViewController: ViewController<StartView, StartPresenter> {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		rootView.loginButton.addTarget(
			self,
			action: #selector(didTapLogin),
			for: .touchUpInside
		)
		
		rootView.registerButton.addTarget(
			self,
			action: #selector(didTapRegister),
			for: .touchUpInside
		)
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateClouds()
        fadeInElements()
	}
}


// MARK: Private
private extension StartViewController {
	@objc
	func didTapLogin() {
		presenter.loginAction()
	}
	
	@objc
	func didTapRegister() {
		presenter.registerAction()
	}
	
	func animateClouds() {
		UIView.animate(
			withDuration: cloudsAnimationDuration,
			delay: .zero,
			usingSpringWithDamping: cloudsSpringDamping,
			initialSpringVelocity: .zero,
			options: .curveEaseOut
		) { [rootView] in
			rootView.cloud1Left.constant = cloud1LeftTargetConstant
			rootView.cloud1.alpha = targetAlpha
			rootView.cloud2Right.constant = cloud2RightTargetConstant
			rootView.cloud2.alpha = targetAlpha
			rootView.cloud3Left.constant = cloud3LeftTargetConstant
			rootView.cloud3.alpha = targetAlpha
			rootView.layoutIfNeeded()
		}
	}
	
	func fadeInElements() {
		[
			rootView.welcomeLabel,
			rootView.larosaLabel,
			rootView.becomeLabel,
			rootView.loginButton,
			rootView.registerButton
		]
		.enumerated()
		.forEach { index, view in
			UIView.animate(
				withDuration: fadeInDuration,
				delay: fadeInInitialDelay + CGFloat(index) * fadeInAddedDelay,
				options: .curveEaseIn
			) { [view, rootView] in
				view?.alpha = targetAlpha
				rootView.layoutIfNeeded()
			}
		}
	}
}


// MARK: Layout constants
private let cloudsAnimationDuration: CGFloat = 2.0
private let cloudsSpringDamping: CGFloat = 2.0

private let cloud1LeftTargetConstant: CGFloat = -128.0
private let cloud2RightTargetConstant: CGFloat = -133.0
private let cloud3LeftTargetConstant: CGFloat = -180.0


private let fadeInDuration: CGFloat = 0.5
private let fadeInInitialDelay: CGFloat = 1.0
private let fadeInAddedDelay: CGFloat = 0.3

private let targetAlpha: CGFloat = 1.0
