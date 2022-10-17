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

  enum ButtonConfigurations {
    static func geBlueButtonConfiguration() -> Configuration {
      var configuration: Configuration = .filled()
      configuration.cornerStyle = .capsule
      configuration.baseForegroundColor = Colors.white
      configuration.baseBackgroundColor = Colors.activeButton
      configuration.contentInsets = .init(top: 10, leading: 30, bottom: 10, trailing: 30)
      return configuration
    }

    static func getWhiteButtonConfiguration() -> Configuration {
      var configuration: Configuration = .filled()
      configuration.cornerStyle = .capsule
      configuration.baseForegroundColor = Colors.black
      configuration.baseBackgroundColor = .white
      configuration.contentInsets = .init(top: 10, leading: 30, bottom: 10, trailing: 30)
      return configuration
    }
  }

  private func setDefaultShadow() {
    layer.shadowColor = Colors.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 6)
    layer.shadowOpacity = 0.2
    layer.shadowRadius = 12
    layer.masksToBounds = false
  }

  func setButtonConfiguration(_ configuration: Configuration, shadow: Bool = true) {
    self.configuration = configuration
    setDefaultShadow()
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
