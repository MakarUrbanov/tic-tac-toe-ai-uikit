//
// Created by makar on 10/17/22.
//

import UIKit

protocol SelectItemProtocol: AnyObject {
  func onChangeSelectedSide(side: SelectedSide)
}

extension SideSelector {

  class SelectorItem: BaseStackView {

    private var contentPlaceholder: SelectorContent
    private var selectedPoint: InteractiveSelectedPoint

    weak var onChangeSelectedItemDelegate: SelectItemProtocol?
    var onChangeSelectedSide: ((SelectorItem) -> Void)?

    init(content: SelectorContent) {
      contentPlaceholder = content
      selectedPoint = InteractiveSelectedPoint(size: 50)

      super.init(frame: .zero)
    }

    required init(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

  }

}

extension SideSelector.SelectorItem {

  override func onPressHandler(sender: UILongPressGestureRecognizer) {
    super.onPressHandler(sender: sender)

    if sender.state == .ended {
      onChangeSelectedItemDelegate?.onChangeSelectedSide(side: contentPlaceholder.1)
      onChangeSelectedSide?(self)
    }
  }

  func setItemActive() {
    selectedPoint.isSelectedHandler(true)
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 0.5,
      initialSpringVelocity: 0,
      options: .allowUserInteraction) { [unowned self] in
      contentPlaceholder.0.transform = CGAffineTransformScale(.identity, 1.2, 1.2)
    }
  }

  func setItemInactive() {
    selectedPoint.isSelectedHandler(false)
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 0.5,
      initialSpringVelocity: 0,
      options: .allowUserInteraction) { [unowned self] in
      contentPlaceholder.0.transform = CGAffineTransformScale(.identity, 1, 1)
    }
  }

}

extension SideSelector.SelectorItem {

  override func setViews() {
    super.setViews()

    addArrangedSubview(contentPlaceholder.0)
    addArrangedSubview(selectedPoint)
  }

  override func setConstraints() {
    super.setConstraints()
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    makePressable()

    backgroundColor = .clear
    isUserInteractionEnabled = true

    setLayoutOptions(axis: .vertical, distribution: .fill, spacing: 50)
  }

}
