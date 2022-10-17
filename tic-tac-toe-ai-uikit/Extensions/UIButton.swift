//
// Created by makar on 10/16/22.
//

import UIKit

extension UIButton {
  func makeTitlePressable() {
    addTarget(self, action: #selector(handlePressIn), for: [
      .touchDown,
      .touchDragInside
    ])
    addTarget(self, action: #selector(handlePressOut), for: [
      .touchDragOutside,
      .touchUpInside,
      .touchUpOutside,
      .touchDragExit,
      .touchCancel
    ])
  }

  @objc private func handlePressIn() {
    UIView.animate(withDuration: 0.05) {
      self.titleLabel?.alpha = 0.1
    }
  }

  @objc private func handlePressOut() {
    UIView.animate(withDuration: 0.05) {
      self.titleLabel?.alpha = 1
    }
  }

}
