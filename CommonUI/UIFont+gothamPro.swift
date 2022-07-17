import UIKit

extension UIFont {
	enum Variant {
		case regular
		case medium
		
		var postfix: String {
			name.flatMap { "-" + $0 } ?? ""
		}
		
		private var name: String? {
			switch self {
			case .regular:
				return nil
			case .medium:
				return "Medium"
			}
		}
	}
	
	enum Size: CGFloat {
		/// 18.0
		case large = 18.0
		/// 10.0
		case small = 10.0
	}
	
	static func gothamPro(_ variant: Variant, size: Size) -> UIFont {
		UIFont(
			name: "GothamPro" + variant.postfix,
			size: size.rawValue
		)!
	}
}
