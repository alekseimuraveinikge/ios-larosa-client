import UIKit

class StartView: UIView {
	@IBOutlet var loginButton: GradientButton!
	@IBOutlet var registerButton: UIButton! {
		didSet {
			registerButton.layer.borderColor = UIColor.darkBlue.cgColor
			registerButton.layer.borderWidth = registerBorderWidth
			registerButton.layer.cornerRadius = registerCornerRadius
		}
	}
    
	@IBOutlet var cloud1: UIImageView!
	@IBOutlet var cloud2: UIImageView!
	@IBOutlet var cloud3: UIImageView!
    
	@IBOutlet var cloud1Left: NSLayoutConstraint!
	@IBOutlet var cloud2Right: NSLayoutConstraint!
	@IBOutlet var cloud3Left: NSLayoutConstraint!
    
	@IBOutlet var welcomeLabel: UILabel!
	@IBOutlet var larosaLabel: UILabel!
	@IBOutlet var becomeLabel: UILabel!
	
	private let gradientLayer: CAGradientLayer = {
		let layer = CAGradientLayer()
		layer.colors = [
			UIColor.skyColor.cgColor,
			UIColor.white.cgColor,
		]
		layer.locations = [0, 0.5]
		return layer
	}()
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		layer.insertSublayer(gradientLayer, at: 0)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = bounds
	}
}

// MARK: Layout constants

private let registerBorderWidth: CGFloat = 3.0
private let registerCornerRadius: CGFloat = 24.0
