//
//  GameConfigurationViewController.swift
//  tic-tac-toe-ai-uikit
//
//  Created by makar on 10/16/22.
//

import UIKit

class GameConfigurationViewController: BaseViewController {

  private let stackView = UIStackView()

  private let marksStack = MarksView()
  private let titleLabel = UILabel()

  private let withAiButton = BaseRoundedButton(with: "With AI")
  private let withFriendButton = BaseRoundedButton(with: "With a friend")
  private let buttonsWrapper = BaseView()

  private func getMarksSize() -> CGFloat {
    view.bounds.width / 2.4
  }

}

extension GameConfigurationViewController {

  @objc private func withAiButtonPressed() {
    print("pressed AI")
  }

  @objc private func withFriendButtonPressed() {
    print("pressed Friend")
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

      marksStack.widthAnchor.constraint(equalToConstant: getMarksSize() * 1.85),

      titleLabel.topAnchor.constraint(equalTo: marksStack.bottomAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),

      buttonsWrapper.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
      buttonsWrapper.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

      withAiButton.centerXAnchor.constraint(equalTo: buttonsWrapper.centerXAnchor),
      withAiButton.widthAnchor.constraint(equalToConstant: buttonsWidth),

      withFriendButton.topAnchor.constraint(equalTo: withAiButton.bottomAnchor, constant: verticalMargin / 3),
      withFriendButton.centerXAnchor.constraint(equalTo: buttonsWrapper.centerXAnchor),
      withFriendButton.widthAnchor.constraint(equalToConstant: buttonsWidth),
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    stackView.alignment = .center
    stackView.axis = .vertical
    stackView.distribution = .fillEqually

    marksStack.drawMarks(marksSize: getMarksSize())

    titleLabel.text = "Choose your play mode"
    titleLabel.textColor = Colors.Text.primaryBlack
    titleLabel.font = Fonts.helveticaSemiBold(size: 22)
    titleLabel.textAlignment = .center

    withAiButton.addTarget(self, action: #selector(withAiButtonPressed), for: .touchUpInside)
    let buttonWithAiConfiguration = BaseRoundedButton.ButtonConfigurations.geBlueButtonConfiguration()
    withAiButton.setButtonConfiguration(buttonWithAiConfiguration)

    withFriendButton.addTarget(self, action: #selector(withFriendButtonPressed), for: .touchUpInside)
    withFriendButton.makeTitlePressable()
    let buttonWithFriendConfiguration = BaseRoundedButton.ButtonConfigurations.getWhiteButtonConfiguration()
    withFriendButton.setButtonConfiguration(buttonWithFriendConfiguration)
  }

}
