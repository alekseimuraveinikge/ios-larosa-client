import UIKit

extension UIColor {
	convenience init(
		red: Int,
		green: Int,
		blue: Int,
		alpha: Double
	) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		
		self.init(
			red: CGFloat(red) / 255.0,
			green: CGFloat(green) / 255.0,
			blue: CGFloat(blue) / 255.0,
			alpha: CGFloat(alpha)
		)
	}
	
	convenience init(
		_ netHex: Int,
		alpha: Double = 1.0
	) {
		self.init(
			red: (netHex >> 16) & 0xFF,
			green: (netHex >> 8) & 0xFF,
			blue: netHex & 0xFF,
			alpha: alpha
		)
	}
}
