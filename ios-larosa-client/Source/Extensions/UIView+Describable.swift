import UIKit

protocol Describable {
	static var description: String { get }
}

extension Describable {
	static var description: String { String(describing: Self.self) }
}

extension UIView: Describable {}
