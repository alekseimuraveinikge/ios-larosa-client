import UIKit

class RootViewController: ViewController<RootView, RootPresenter> {
	override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
		presenter.didAppear()
    }
}
