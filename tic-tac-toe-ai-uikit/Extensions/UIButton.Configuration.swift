//
// Created by makar on 10/19/22.
//

import UIKit

extension UIButton.Configuration {

  enum DefaultRoundedButtonStyles {
    static var blueActionButton: UIButton.Configuration {
      var configuration = filled()
      configuration.cornerStyle = .capsule
      configuration.baseForegroundColor = Colors.white
      configuration.baseBackgroundColor = Colors.activeButton
      configuration.contentInsets = .init(top: 10, leading: 30, bottom: 10, trailing: 30)
      return configuration
    }

    static var whiteButton: UIButton.Configuration {
      var configuration = filled()
      configuration.cornerStyle = .capsule
      configuration.baseForegroundColor = Colors.black
      configuration.baseBackgroundColor = .white
      configuration.contentInsets = .init(top: 10, leading: 30, bottom: 10, trailing: 30)
      return configuration
    }

    static var plainBlueButton: UIButton.Configuration {
      var configuration = UIButton.Configuration.plain()
      configuration.baseForegroundColor = Colors.activeButton
      configuration.contentInsets = .init(top: 10, leading: 30, bottom: 10, trailing: 30)
      return configuration
    }
  }

}
