class RegistrationPresenterImpl {
	private let moduleOutput: RegistrationModuleOutput

	init(moduleOutput: RegistrationModuleOutput) {
		self.moduleOutput = moduleOutput
	}
}

// MARK: RegistrationPresenter

extension RegistrationPresenterImpl: RegistrationPresenter {
	func backAction() {
		moduleOutput.goToStartScreen()
	}
	
	func loginAction() {
		moduleOutput.goToLoginScreen()
	}
	
	func registerAction() {
		// TODO: Register business logic
	}
}
