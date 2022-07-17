import UIKit

class RootFlowCoordinator {
	private let authService: AuthService
	private weak var rootController: UIViewController?
    
	init(authService: AuthService) {
		self.authService = authService
	}
	
	func launchViewController() -> UIViewController {
		let controller = RootViewController(
			presenter: RootPresenterImpl(
				moduleOutput: self,
				authService: authService
			)
		)
		rootController = controller
		return controller
	}
}

// MARK: Root Output

extension RootFlowCoordinator: RootModuleOutput {
	func showAuthorizationScreen() {
		let authorizationCoordinator = AuthorizationFlowCoordinator()
		let authorizationRootController = authorizationCoordinator.launchViewController()

		authorizationRootController.modalPresentationStyle = .fullScreen
		authorizationRootController.modalTransitionStyle = .coverVertical

		rootController?.present(authorizationRootController, animated: true)
	}
    
	func showHomeScreen() {
		// TODO: Show home screen
	}
}
