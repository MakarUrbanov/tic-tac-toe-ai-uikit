//
// Created by makar on 10/17/22.
//

import UIKit

class SideSelector: BaseStackView {

  typealias SelectorContent = (UIView, SelectedSide)

  var selectedItem: SelectedSide = .cross
  var selectors: [SelectorItem] = []

  func setContent(_ content: [SelectorContent], delegator: SelectItemProtocol) {
    let renderedContent = content.enumerated().map { (index, item) in
      let view = SelectorItem(content: item)

      if index == 0 {
        selectedItem = item.1
        view.setItemActive()
      }

      view.onChangeSelectedItemDelegate = delegator
      view.onChangeSelectedSide = onChangeSelectedSide
      return view
    }
    selectors = renderedContent

    renderContent()
  }

  private func renderContent() {
    selectors.forEach { view in
      addArrangedSubview(view)
    }
  }

}

extension SideSelector {

  func onChangeSelectedSide(origin: SelectorItem) {
    selectors.forEach { view in
      if origin === view {
        view.setItemActive()
      } else {
        view.setItemInactive()
      }
    }
  }

}

extension SideSelector {

  override func setViews() {
    super.setViews()
  }

  override func setConstraints() {
    super.setConstraints()
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    setLayoutOptions()
  }

}
