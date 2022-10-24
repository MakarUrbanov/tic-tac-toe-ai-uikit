//
// Created by makar on 10/19/22.
//

import UIKit

enum BoardCellState {
  case cross, nought, empty
}

class BoardCell: BaseCollectionViewCell {

  static let identifier = "BoardCollectionViewCell"

  private(set) var state: BoardCellState = .empty

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension BoardCell {
  private func setMarkConstraints(_ mark: UIView) {
    mark.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    mark.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
  }

  private func drawMark(_ mark: DrawableMarkProtocol.Type) {
    let markInstance = mark.init(width: bounds.width * 0.8, withShadow: true)
    markInstance.draw()
    markInstance.transform = CGAffineTransformScale(.identity, 2, 2)
    markInstance.alpha = 0
    setView(markInstance)
    setMarkConstraints(markInstance)
    UIView.animate(
      withDuration: 0.8,
      delay: 0,
      usingSpringWithDamping: 0.8,
      initialSpringVelocity: 0,
      options: .allowUserInteraction
    ) {
      markInstance.transform = CGAffineTransformScale(.identity, 1, 1)
      markInstance.alpha = 1
    }
  }

  private func getCrossMark() -> DrawableMarkProtocol {
    let mark = Cross(width: bounds.width, withShadow: false)
    return mark
  }

  private func getNoughtMark() -> DrawableMarkProtocol {
    let mark = Nought(width: bounds.width, withShadow: false)
    return mark
  }

  func setMark(_ mark: BoardCellState) {
    switch mark {
      case .cross:
        drawMark(Cross.self)
        state = .cross

      case .nought:
        drawMark(Nought.self)
        state = .nought

      case .empty:
        state = .empty
    }
  }

  func refreshCell() {
    state = .empty
    subviews.forEach { $0.removeFromSuperview() }
  }
}
