import UIKit

class GradientButton: UIButton {
	@IBInspectable var buttonTitle: String = "" {
		didSet {
			setTitle(buttonTitle, for: .normal)
		}
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		layer.insertSublayer(gradientLayer, at: 0)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = bounds
	}
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
			UIColor.lightBlue.cgColor,
			UIColor.darkBlue.cgColor
		]
        layer.cornerRadius = 24
        return layer
    }()
}
