//
// Created by makar on 10/30/22.
//

import UIKit

class GameOverMessage: BaseView {
  let message = UILabel()
  let button = BaseRoundedButton(with: "Restart")

  func setMessage(_ message: String) {
    self.message.text = message
  }

  func addButtonTarget(_ target: Any?, actions: Selector) {
    button.addTarget(target, action: actions, for: .touchUpInside)
  }
}

extension GameOverMessage {

  override func setViews() {
    super.setViews()

    setView(message)
    setView(button)
  }

  override func setConstraints() {
    super.setConstraints()

    NSLayoutConstraint.activate([
      message.topAnchor.constraint(equalTo: topAnchor),
      message.centerXAnchor.constraint(equalTo: centerXAnchor),

      button.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 20),
      button.centerXAnchor.constraint(equalTo: centerXAnchor),
      button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    backgroundColor = Colors.black
    setDefaultShadow()

    message.textColor = Colors.gray

    button.setButtonConfiguration(.DefaultRoundedButtonStyles.blueActionButton)
    button.makeTitlePressable()
  }

}
