import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
	var window: UIWindow?
	
	private let authService = AuthServiceImpl()
    private lazy var rootFlowCoordinator: RootFlowCoordinator = RootFlowCoordinator(authService: authService)
    
    func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
        
        UITextField.appearance().tintColor = UIColor.paleBlue
                
		let window = UIWindow(frame: UIScreen.main.bounds)
		self.window = window
				
		window.rootViewController = rootFlowCoordinator.launchViewController()
		window.makeKeyAndVisible()
		
        return true
    }
}
