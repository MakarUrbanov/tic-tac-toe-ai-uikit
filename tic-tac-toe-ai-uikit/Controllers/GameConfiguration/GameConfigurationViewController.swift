//
//  GameConfigurationViewController.swift
//  tic-tac-toe-ai-uikit
//
//  Created by makar on 10/16/22.
//

import UIKit

final class GameConfigurationViewController: BaseViewController {

  private let stackView = BaseStackView()

  private let marksStack = MarksView()
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Choose your play mode"
    return label
  }()

  private let withAiButton = BaseRoundedButton(with: "With AI")
  private let withFriendButton = BaseRoundedButton(with: "With a friend")
  private let buttonsWrapper = BaseView()

  private func getMarksSize() -> CGFloat {
    view.bounds.width / 2.4
  }

}

extension GameConfigurationViewController {

  private func navigateToPickSideController(selectedMode: SelectedMode) {
    let controller = PickSideViewController(selectedMode: selectedMode)
    navigationController?.pushViewController(controller, animated: true)
  }

  @objc private func withAiButtonPressed() {
    navigateToPickSideController(selectedMode: .ai)
  }

  @objc private func withFriendButtonPressed() {
    navigateToPickSideController(selectedMode: .friend)
  }

}

extension GameConfigurationViewController {

  override func setViews() {
    super.setViews()

    view.setView(stackView)

    stackView.addArrangedSubview(marksStack)
    stackView.addArrangedSubview(titleLabel)

    buttonsWrapper.setView(withAiButton)
    buttonsWrapper.setView(withFriendButton)
    stackView.addArrangedSubview(buttonsWrapper)
  }

  override func setConstraints() {
    super.setConstraints()

    let verticalMargin = view.bounds.height * 0.1
    let buttonsWidth = view.bounds.width / 2

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -verticalMargin),
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: verticalMargin),

      titleLabel.topAnchor.constraint(equalTo: marksStack.bottomAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),

      buttonsWrapper.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
      buttonsWrapper.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

      withAiButton.centerXAnchor.constraint(equalTo: buttonsWrapper.centerXAnchor),
      withAiButton.widthAnchor.constraint(equalToConstant: buttonsWidth),

      withFriendButton.topAnchor.constraint(equalTo: withAiButton.bottomAnchor, constant: verticalMargin / 3),
      withFriendButton.centerXAnchor.constraint(equalTo: buttonsWrapper.centerXAnchor),
      withFriendButton.widthAnchor.constraint(equalToConstant: buttonsWidth)
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    stackView.setLayoutOptions(axis: .vertical)

    marksStack.drawMarks(marksSize: getMarksSize())

    titleLabel.textColor = Colors.Text.primaryBlack
    titleLabel.font = Fonts.title
    titleLabel.textAlignment = .center

    withAiButton.addTarget(self, action: #selector(withAiButtonPressed), for: .touchUpInside)
    withAiButton.setButtonConfiguration(.DefaultRoundedButtonStyles.blueActionButton)

    withFriendButton.addTarget(self, action: #selector(withFriendButtonPressed), for: .touchUpInside)
    withFriendButton.makeTitlePressable()
    withFriendButton.setButtonConfiguration(.DefaultRoundedButtonStyles.whiteButton)
  }

}
