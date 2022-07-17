import UIKit

class AuthorizationFlowCoordinator {
	private weak var startViewController: UIViewController?
    private weak var navigationController: UINavigationController?
    
	func launchViewController() -> UIViewController {
        let startViewController = StartViewController(
			presenter: StartPresenterImpl(moduleOutput: self)
		)
		let navigationController = UINavigationController(
			rootViewController: startViewController
		)
		
		navigationController.setNavigationBarHidden(true, animated: false)
		navigationController.isHeroEnabled = true
		
		self.startViewController = startViewController
		self.navigationController = navigationController
        return navigationController
    }
	
	func goToStartScreen() {
		navigationController?.popViewController(animated: true)
	}
}


// MARK: StartModuleOutput
extension AuthorizationFlowCoordinator: StartModuleOutput {
    func showLoginScreen() {
		navigationController?.pushViewController(loginController, animated: true)
    }
    
	func showRegistrationScreen() {
		navigationController?.pushViewController(registrationController, animated: true)
    }
}


// MARK: LoginModuleOutput
extension AuthorizationFlowCoordinator: LoginModuleOutput {
    func goToRegistration() {
		guard let startViewController = startViewController else { return }
		navigationController?.setViewControllers(
			[startViewController, registrationController],
			animated: true
		)
    }
}


// MARK: RegistrationModuleOutput
extension AuthorizationFlowCoordinator: RegistrationModuleOutput {
    func goToLoginScreen() {
		guard let startViewController = startViewController else { return }
		navigationController?.setViewControllers(
			[startViewController, loginController],
			animated: true
		)
    }
}


// MARK: Private
extension AuthorizationFlowCoordinator {
	private var loginController: UIViewController {
		let controller = LoginViewController(
			presenter: LoginPresenterImpl(moduleOutput: self)
		)
		controller.modalTransitionStyle = .coverVertical
		controller.modalPresentationStyle = .fullScreen
		return controller
	}
	
	private var registrationController: UIViewController {
		let controller = RegistrationViewController(
			presenter: RegistrationPresenterImpl(moduleOutput: self)
		)
		controller.modalTransitionStyle = .coverVertical
		controller.modalPresentationStyle = .fullScreen
		return controller
	}
}
