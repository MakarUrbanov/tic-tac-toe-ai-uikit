//
// Created by makar on 10/16/22.
//

import UIKit

class MarksView: BaseStackView {

  private var cross = Cross(width: 100)
  private var circle = Circle(width: 100)

  func drawMarks(marksSize: CGFloat) {
    cross = Cross(width: marksSize)
    circle = Circle(width: marksSize)

    cross.draw()
    circle.draw()

    addArrangedSubview(cross)
    addArrangedSubview(circle)
  }

}

extension MarksView {

  override func setViews() {
    super.setViews()
  }

  override func setConstraints() {
    super.setConstraints()
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    setLayoutOptions(axis: .horizontal, distribution: .fillEqually, spacing: -30)

    cross.backgroundColor = .clear
    circle.backgroundColor = .clear
  }

}
