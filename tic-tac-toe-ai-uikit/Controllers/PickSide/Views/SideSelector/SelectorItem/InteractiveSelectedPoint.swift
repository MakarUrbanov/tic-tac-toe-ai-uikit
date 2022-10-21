//
// Created by makar on 10/18/22.
//

import UIKit

class InteractiveSelectedPoint: BaseView {

  private(set) var isSelected: Bool {
    willSet {
      newValue ? animateOnSelect() : animateOnDeselect()
    }
  }
  private var size: CGFloat
  private let dot = UIView()

  init(size: CGFloat, isSelected: Bool = false) {
    self.isSelected = isSelected
    self.size = size

    super.init(frame: .zero)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension InteractiveSelectedPoint {

  func isSelectedHandler(_ isSelected: Bool) {
    self.isSelected = isSelected
  }

  private func animateOnSelect() {
    dot.isHidden = false
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 3,
      initialSpringVelocity: 0,
      options: .allowUserInteraction) { [self] in
      dot.alpha = 1
      dot.transform = CGAffineTransformScale(.identity, 1, 1)
      layer.borderColor = getColor(true).cgColor
    }
  }

  private func animateOnDeselect() {
    dot.alpha = 0
    dot.transform = CGAffineTransformScale(.identity, 0.0001, 0.0001)
    dot.isHidden = true

    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 3,
      initialSpringVelocity: 0,
      options: .allowUserInteraction,
      animations: { [self] in
        layer.borderColor = getColor(false).cgColor
      }
    )
  }

  private func getColor(_ isSelected: Bool) -> UIColor {
    isSelected ? Colors.activeButton : Colors.gray
  }

}

extension InteractiveSelectedPoint {

  override func setViews() {
    super.setViews()

    setView(dot)
  }

  override func setConstraints() {
    super.setConstraints()

    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: size),
      heightAnchor.constraint(equalToConstant: size),

      dot.centerXAnchor.constraint(equalTo: centerXAnchor),
      dot.centerYAnchor.constraint(equalTo: centerYAnchor),
      dot.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
      dot.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4)
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    layer.borderWidth = 6
    layer.borderColor = getColor(isSelected).cgColor
    layer.cornerRadius = size / 2
    backgroundColor = .clear

    dot.layer.cornerRadius = size * 0.4 / 2
    dot.backgroundColor = getColor(true)
    dot.isHidden = !isSelected
  }

}
