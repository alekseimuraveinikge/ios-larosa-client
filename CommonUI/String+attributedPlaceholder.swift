import UIKit

extension String {
	func attributedWith(color: UIColor) -> NSAttributedString {
		NSAttributedString(
			string: self,
			attributes: [
				.font: UIFont.gothamPro(.medium, size: .large) as Any,
				.foregroundColor: color
			]
		)
	}

}
