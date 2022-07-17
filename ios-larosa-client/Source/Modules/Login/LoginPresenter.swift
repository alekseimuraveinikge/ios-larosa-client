class LoginPresenterImpl {
	private let moduleOutput: LoginModuleOutput

	init(moduleOutput: LoginModuleOutput) {
		self.moduleOutput = moduleOutput
	}
}

// MARK: LoginPresenter

extension LoginPresenterImpl: LoginPresenter {
	func backAction() {
		moduleOutput.goToStartScreen()
	}
	
	func registerAction() {
		moduleOutput.goToRegistration()
	}
	
	func loginAction() {
		// TODO: LogIn business logic
	}
}
