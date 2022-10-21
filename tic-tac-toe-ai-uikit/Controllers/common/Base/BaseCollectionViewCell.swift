//
// Created by makar on 10/20/22.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

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

@objc extension BaseCollectionViewCell {

  func setViews() {
  }

  func setConstraints() {
  }

  func setAppearanceConfiguration() {
  }

}
