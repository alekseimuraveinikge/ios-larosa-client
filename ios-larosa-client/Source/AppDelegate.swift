import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	
	private let authService = AuthServiceImpl()
	private lazy var rootFlowCoordinator: RootFlowCoordinator = .init(authService: authService)
    
	func application(
		_: UIApplication,
		didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		UITextField.appearance().tintColor = UIColor.paleBlue
                
		let window = UIWindow(frame: UIScreen.main.bounds)
		self.window = window
				
		window.rootViewController = rootFlowCoordinator.launchViewController()
		window.makeKeyAndVisible()
		
		return true
	}
}
