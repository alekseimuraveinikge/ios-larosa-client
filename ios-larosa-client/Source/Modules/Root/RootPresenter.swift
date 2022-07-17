class RootPresenterImpl {
	private let moduleOutput: RootModuleOutput
	private let authService: AuthService

	init(moduleOutput: RootModuleOutput, authService: AuthService) {
		self.moduleOutput = moduleOutput
		self.authService = authService
	}
}

// MARK: RootPresenter

extension RootPresenterImpl: RootPresenter {
	func didAppear() {
		if authService.isAuthorized {
			moduleOutput.showHomeScreen()
		} else {
			moduleOutput.showAuthorizationScreen()
		}
	}
}
