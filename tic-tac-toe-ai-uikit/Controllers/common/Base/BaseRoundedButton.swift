//
// Created by makar on 10/16/22.
//

import UIKit

class BaseRoundedButton: BaseButton {

  init(with title: String) {
    super.init(frame: .zero)

    setTitle(title, for: .normal)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension BaseRoundedButton {

  private func setDefaultShadow() {
    layer.shadowColor = Colors.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 6)
    layer.shadowOpacity = 0.2
    layer.shadowRadius = 12
    layer.masksToBounds = false
  }

  func setButtonConfiguration(_ configuration: Configuration, withShadow: Bool = true) {
    self.configuration = configuration
    if withShadow {
      setDefaultShadow()
    }
  }

}

extension BaseRoundedButton {

  override func setViews() {
    super.setViews()
  }

  override func setConstraints() {
    super.setConstraints()
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()
  }

}
