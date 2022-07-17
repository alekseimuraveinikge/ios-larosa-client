import UIKit

class StartView: UIView {
    @IBOutlet weak var loginButton: GradientButton!
	@IBOutlet weak var registerButton: UIButton! {
		didSet {
			registerButton.layer.borderColor = UIColor.darkBlue.cgColor
			registerButton.layer.borderWidth = registerBorderWidth
			registerButton.layer.cornerRadius = registerCornerRadius
		}
	}
    
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    
    @IBOutlet weak var cloud1Left: NSLayoutConstraint!
    @IBOutlet weak var cloud2Right: NSLayoutConstraint!
    @IBOutlet weak var cloud3Left: NSLayoutConstraint!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var larosaLabel: UILabel!
    @IBOutlet weak var becomeLabel: UILabel!
	
	private let gradientLayer: CAGradientLayer = {
		let layer = CAGradientLayer()
		layer.colors = [
			UIColor.skyColor.cgColor,
			UIColor.white.cgColor
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
