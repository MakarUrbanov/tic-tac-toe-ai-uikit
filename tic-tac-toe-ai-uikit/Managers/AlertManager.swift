//
// Created by makar on 10/23/22.
//

import UIKit

class AlertManager: UIAlertController {

  required convenience init(title: String?, message: String?) {
    self.init(title: title, message: message, preferredStyle: .alert)
  }

  static func getDefaultAlert(title: String?, message: String?) -> UIAlertController {
    self.init(title: title, message: message)
        .addActionButton(title: "OK", style: .default)
  }

  func addActionButton(
    title: String,
    style: UIAlertAction.Style,
    handler: ((UIAlertAction) -> Void)? = nil
  ) -> UIAlertController {
    let action = UIAlertAction(title: title, style: style, handler: handler)
    addAction(action)
    return self
  }

}
