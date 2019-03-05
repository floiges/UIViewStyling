import UIKit
import PlaygroundSupport

var str = "Hello, playground"

struct ViewStyle<T> {
    let style: (T) -> Void
}

extension ViewStyle {
    func compose(with style: ViewStyle<T>) -> ViewStyle<T> {
        return ViewStyle<T> {
            self.style($0)
            style.style($0)
        }
    }
}

extension ViewStyle where T: UIButton {
    static var filled: ViewStyle<UIButton> {
        return ViewStyle<UIButton> {
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .red
        }
    }
    
    static var rounded: ViewStyle<UIButton> {
        return ViewStyle<UIButton> {
            $0.layer.cornerRadius = 4.0
        }
    }
    
    static var roundedAndFilled: ViewStyle<UIButton> {
        return filled.compose(with: rounded)
    }
}

protocol Stylable {
    init()
}

extension UIView: Stylable {}

extension Stylable {
    init(style: ViewStyle<Self>) {
        self.init()
        apply(style)
    }
    
    func apply(_ style: ViewStyle<Self>) {
        style.style(self)
    }
}


let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
//ViewStyle<UIButton>.roundedAndFilled.style(button)
//style(button, with: .roundedAndFilled)
button.apply(.roundedAndFilled)
//filled.style(button)
//rounded.style(button)
//
//let roundedAndFilled = filled.compose(with: rounded)
PlaygroundPage.current.liveView = button
