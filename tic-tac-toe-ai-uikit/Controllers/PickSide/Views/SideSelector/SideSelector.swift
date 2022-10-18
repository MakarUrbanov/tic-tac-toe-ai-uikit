//
// Created by makar on 10/17/22.
//

import UIKit

class SideSelector: BaseStackView {

  typealias SelectorContent = (UIView, SelectedSide)

  var selectedItem: SelectedSide = .cross
  var selectors: [SelectorItem] = []

}

extension SideSelector {

  func setContent(_ content: [SelectorContent], delegator: SelectItemProtocol) {
    let renderedContent = content.enumerated().map { (index, item) in
      let view = SelectorItem(content: item)

      setInitialActivityByIndex(index, of: view, withMode: item.1)

      view.onChangeSelectedItemDelegate = delegator
      view.onChangeSelectedSide = onChangeSelectedSide
      return view
    }
    selectors = renderedContent

    renderContent()
  }

  private func setInitialActivityByIndex(_ index: Int, of item: SelectorItem, withMode side: SelectedSide) {
    if index == 0 {
      selectedItem = side
      item.setItemActive()
    } else {
      item.setItemInactive()
    }
  }

  private func renderContent() {
    selectors.forEach { view in
      addArrangedSubview(view)
    }
  }

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
