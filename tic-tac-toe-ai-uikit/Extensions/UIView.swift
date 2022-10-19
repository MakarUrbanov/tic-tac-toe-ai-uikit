//
// Created by makar on 10/16/22.
//

import UIKit

extension UIView {
  func setView(_ view: UIView) {
    addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
  }
}

extension UIView {
  func makePressable() {
    let gestureRecognizer = UILongPressGestureRecognizer(
      target: self,
      action: #selector(viewPressed(sender:activeOpacity:))
    )
    gestureRecognizer.minimumPressDuration = 0
    addGestureRecognizer(gestureRecognizer)
  }

  @objc func viewPressed(sender: UILongPressGestureRecognizer, activeOpacity: CGFloat = 0.5) {
    if sender.state == .began {
      UIView.animate(withDuration: 0.05, delay: 0, options: .allowUserInteraction) {
        self.alpha = activeOpacity
      }
    } else if sender.state == .ended {
      UIView.animate(withDuration: 0.05, delay: 0, options: .allowUserInteraction) {
        self.alpha = 1
      }
    }
  }
}

extension UIView {
  func setDefaultShadow() {
    layer.shadowColor = Colors.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 6)
    layer.shadowOpacity = 0.2
    layer.shadowRadius = 12
    layer.masksToBounds = false
  }
}
