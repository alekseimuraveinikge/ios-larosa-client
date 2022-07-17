protocol RegistrationModuleOutput {
	func goToStartScreen()
	func goToLoginScreen()
}

protocol RegistrationPresenter {
	func backAction()
	func loginAction()
	func registerAction()
}
