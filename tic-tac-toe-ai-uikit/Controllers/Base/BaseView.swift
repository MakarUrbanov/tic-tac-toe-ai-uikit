//
// Created by makar on 10/16/22.
//

import UIKit

class BaseView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)

    setViews()
    setConstraints()
    setAppearanceConfiguration()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

@objc extension BaseView {

  func setViews() {
  }

  func setConstraints() {
  }

  func setAppearanceConfiguration() {
    backgroundColor = Colors.background
  }

}
