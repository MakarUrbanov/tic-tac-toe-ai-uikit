//
// Created by makar on 10/19/22.
//

import UIKit

class GameScore: BaseView {

  private var playerScore = 0 { didSet { scoresChanged() } }
  private var secondPlayerScore = 0 { didSet { scoresChanged() } }
  private let selectedMode: SelectedGameMode

  // UI
  private let gameScoreContainer = BaseView()
  private let gameScoreLabel = UILabel()

  private let playerName = UILabel()
  private let secondPlayerName = UILabel()

  private let containerStackView = BaseStackView()

  private let selectorLine = BaseView()

  init(mode: SelectedGameMode) {
    selectedMode = mode

    super.init(frame: .zero)
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension GameScore {

  private func scoresChanged() {
    gameScoreLabel.text = "\(playerScore) - \(secondPlayerScore)"
  }

}

extension GameScore {

  func changeTurn() {
    let isPlayerMove = selectorLine.transform.tx == 0

    UIView.animate(
      withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0) { [self] in
      selectorLine.transform = isPlayerMove
      ? CGAffineTransformMakeTranslation(secondPlayerName.frame.maxX - playerName.bounds.width - 30, 0)
      : CGAffineTransformMakeTranslation(0, 0)
    }

  }

}

@objc extension GameScore {

  override func setViews() {
    super.setViews()

    setView(containerStackView)

    containerStackView.addArrangedSubview(playerName)

    gameScoreContainer.setView(gameScoreLabel)
    containerStackView.addArrangedSubview(gameScoreContainer)

    containerStackView.addArrangedSubview(secondPlayerName)

    setView(selectorLine)
  }

  override func setConstraints() {
    super.setConstraints()

    print(frame, bounds)

    NSLayoutConstraint.activate([
      containerStackView.widthAnchor.constraint(equalTo: widthAnchor),
      containerStackView.topAnchor.constraint(equalTo: topAnchor),
      containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),

      gameScoreContainer.heightAnchor.constraint(equalToConstant: 40),

      gameScoreLabel.centerXAnchor.constraint(equalTo: gameScoreContainer.centerXAnchor),
      gameScoreLabel.centerYAnchor.constraint(equalTo: gameScoreContainer.centerYAnchor),

      selectorLine.widthAnchor.constraint(equalTo: playerName.widthAnchor, constant: 20),
      selectorLine.leadingAnchor.constraint(equalTo: playerName.leadingAnchor, constant: 5),
      selectorLine.heightAnchor.constraint(equalToConstant: 40),
      selectorLine.centerYAnchor.constraint(equalTo: playerName.centerYAnchor)
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    containerStackView.setLayoutOptions(axis: .horizontal)

    playerName.text = "You"
    playerName.textColor = Colors.Text.dynamicBlack
    playerName.textAlignment = .center
    playerName.font = Fonts.Custom.helveticaRegular(size: 24)

    secondPlayerName.text = selectedMode == .ai ? "AI" : "Friend"
    secondPlayerName.textColor = Colors.Text.dynamicBlack
    secondPlayerName.textAlignment = .center
    secondPlayerName.font = Fonts.Custom.helveticaRegular(size: 24)

    gameScoreContainer.backgroundColor = Colors.white
    gameScoreContainer.setDefaultShadow()
    gameScoreContainer.layer.cornerRadius = 14

    gameScoreLabel.text = "\(playerScore) - \(secondPlayerScore)"
    gameScoreLabel.font = Fonts.Custom.helveticaBold(size: 24)
    gameScoreLabel.textAlignment = .center
    gameScoreLabel.textColor = Colors.black

    selectorLine.backgroundColor = Colors.white
    selectorLine.layer.zPosition = -1
    selectorLine.layer.cornerRadius = 14
  }

}
