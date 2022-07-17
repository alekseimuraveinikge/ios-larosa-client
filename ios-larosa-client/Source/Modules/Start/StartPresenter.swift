class StartPresenterImpl {
	private let moduleOutput: StartModuleOutput

	init(moduleOutput: StartModuleOutput) {
		self.moduleOutput = moduleOutput
	}
}


// MARK: StartPresenter
extension StartPresenterImpl: StartPresenter {
	func loginAction() {
        moduleOutput.showLoginScreen()
    }
    
    func registerAction() {
        moduleOutput.showRegistrationScreen()
    }
}
