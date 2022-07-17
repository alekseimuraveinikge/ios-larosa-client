import Hero
import UIKit

class RootView: UIView {
	@IBOutlet var ellipseImageView: UIImageView! {
		didSet {
			ellipseImageView.hero.modifiers = [
				.duration(ellipseHeroDuration),
				.scale(ellipseHeroScale),
			]
		}
	}
    
	@IBOutlet var stack: UIStackView! {
		didSet {
			stack.hero.modifiers = [
				.fade,
				.duration(stackHeroDuration),
			]
		}
	}
    
	@IBOutlet var salon: UIImageView! {
		didSet {
			salon.hero.modifiers = [
				.translate(y: salonHeroY),
				.duration(salonHeroDuration),
			]
		}
	}
}

// MARK: Layout constants

private let ellipseHeroDuration: CGFloat = 1.5
private let ellipseHeroScale: CGFloat = 10.0

private let stackHeroDuration: CGFloat = 0.7

private let salonHeroY: CGFloat = -5.0
private let salonHeroDuration: CGFloat = 1.0
