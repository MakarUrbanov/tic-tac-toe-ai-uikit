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
