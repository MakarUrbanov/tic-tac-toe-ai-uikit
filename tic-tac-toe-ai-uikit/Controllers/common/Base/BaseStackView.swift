//
// Created by makar on 10/16/22.
//

import UIKit

class BaseStackView: UIStackView {

  override init(frame: CGRect) {
    super.init(frame: frame)

    setViews()
    setConstraints()
    setAppearanceConfiguration()
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

@objc extension BaseStackView {

  func setViews() {
  }

  func setConstraints() {
  }

  func setAppearanceConfiguration() {
  }

}
