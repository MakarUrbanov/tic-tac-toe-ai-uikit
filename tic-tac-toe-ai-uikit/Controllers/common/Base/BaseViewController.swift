//
// Created by makar on 10/16/22.
//

import UIKit

class BaseViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    setViews()
    setConstraints()
    setAppearanceConfiguration()
  }

}

@objc extension BaseViewController {

  func setViews() {
  }

  func setConstraints() {
  }

  func setAppearanceConfiguration() {
    view.backgroundColor = Colors.background
    navigationController?.interactivePopGestureRecognizer?.delegate = nil
  }

}
