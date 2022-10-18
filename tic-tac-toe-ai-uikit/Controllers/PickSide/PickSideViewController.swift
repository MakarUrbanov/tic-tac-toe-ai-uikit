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

  private var buttonsStackView = BaseStackView()
  private var continueButton = BaseRoundedButton(with: "Continue")
  private var goBackButton = BaseRoundedButton(with: "Go back")

  init(selectedMode: SelectedMode) {
    self.selectedMode = selectedMode

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension PickSideViewController {

  @objc private func continueButtonPressed() {
    let viewController = GameBoardViewController(mode: selectedMode, side: selectedSide)
    navigationController?.pushViewController(viewController, animated: true)
  }

  @objc private func goBackButtonPressed() {
    navigationController?.popViewController(animated: true)
  }

  private func getContentItemSize() -> CGFloat {
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

    stackView.addArrangedSubview(buttonsStackView)
    buttonsStackView.addArrangedSubview(continueButton)
    buttonsStackView.addArrangedSubview(goBackButton)
  }

  override func setConstraints() {
    super.setConstraints()

    let verticalPadding = view.bounds.height * 0.1
    let buttonsWidth = view.bounds.width / 2

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: verticalPadding),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -verticalPadding),
      continueButton.widthAnchor.constraint(equalToConstant: buttonsWidth),
      goBackButton.widthAnchor.constraint(equalToConstant: buttonsWidth)
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    stackView.setLayoutOptions(axis: .vertical, distribution: .fill)

    titleLabel.textColor = Colors.Text.primaryBlack
    titleLabel.font = Fonts.title

    let crossContent = Cross(width: getContentItemSize())
    let circleContent = Circle(width: getContentItemSize())
    crossContent.backgroundColor = .clear
    crossContent.draw()
    circleContent.backgroundColor = .clear
    circleContent.draw()
    let cross = (crossContent, SelectedSide.cross)
    let circle = (circleContent, SelectedSide.circle)
    sideSelector.setContent([cross, circle], delegator: self)

    buttonsStackView.setLayoutOptions(axis: .vertical, spacing: view.bounds.height * 0.03)

    continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
    continueButton.makeTitlePressable()
    continueButton.setButtonConfiguration(.DefaultRoundedButtonStyles.blueActionButton)

    goBackButton.addTarget(self, action: #selector(goBackButtonPressed), for: .touchUpInside)
    goBackButton.makeTitlePressable()
    goBackButton.setButtonConfiguration(.DefaultRoundedButtonStyles.plainBlueButton)
  }

}
