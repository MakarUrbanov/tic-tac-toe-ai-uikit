//
// Created by makar on 10/16/22.
//

import UIKit

final class PickSideViewController: BaseViewController {

  private var selectedMode: SelectedMode
  private var selectedSide: SelectedSide = SelectedSide.cross

  private let stackView = BaseStackView()
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Pick your side"
    return label
  }()
  private var sideSelector = SideSelector()

  init(selectedMode: SelectedMode) {
    self.selectedMode = selectedMode

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func getSideItemSize() -> CGFloat {
    view.bounds.width / 2.6
  }

}

extension PickSideViewController: SelectItemProtocol {
  func onChangeSelectedSide(side: SelectedSide) {
    selectedSide = side
  }
}

extension PickSideViewController {

  override func setViews() {
    super.setViews()

    view.setView(stackView)
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(sideSelector)
  }

  override func setConstraints() {
    super.setConstraints()

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    stackView.setLayoutOptions(axis: .vertical)

    titleLabel.textColor = Colors.Text.primaryBlack
    titleLabel.font = Fonts.title

    let cross = (Cross(width: getSideItemSize()), SelectedSide.cross)
    let circle = (Circle(width: getSideItemSize()), SelectedSide.circle)
    cross.0.backgroundColor = .clear
    circle.0.backgroundColor = .clear
    cross.0.draw()
    circle.0.draw()
    sideSelector.setContent([cross, circle], delegator: self)
  }

}
