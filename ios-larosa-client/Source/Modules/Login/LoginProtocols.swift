protocol LoginModuleOutput {
	func goToStartScreen()
	func goToRegistration()
}

protocol LoginPresenter {
	func backAction()
	func loginAction()
	func registerAction()
}
