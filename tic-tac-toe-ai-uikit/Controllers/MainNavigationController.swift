//
// Created by makar on 10/16/22.
//

import UIKit

class MainNavigationController: UINavigationController {

  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)

    view.frame = UIScreen.main.bounds
    isNavigationBarHidden = true
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
