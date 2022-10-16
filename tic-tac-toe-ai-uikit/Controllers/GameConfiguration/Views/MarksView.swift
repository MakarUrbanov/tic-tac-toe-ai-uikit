//
// Created by makar on 10/16/22.
//

import UIKit

class MarksView: BaseView {

  private let cross = Cross()
  private let circle = Circle()

  func drawMarks(marksSize: CGFloat) {
    cross.draw(width: marksSize, withShadow: true)
    circle.draw(width: marksSize, withShadow: true)
  }

}

extension MarksView {

  override func setViews() {
    super.setViews()

    setView(cross)
    setView(circle)
  }

  override func setConstraints() {
    super.setConstraints()

    NSLayoutConstraint.activate([
      cross.centerYAnchor.constraint(equalTo: centerYAnchor),
      cross.leadingAnchor.constraint(equalTo: leadingAnchor),

      circle.centerYAnchor.constraint(equalTo: centerYAnchor),
      circle.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    cross.backgroundColor = .clear
    circle.backgroundColor = .clear
  }

}
