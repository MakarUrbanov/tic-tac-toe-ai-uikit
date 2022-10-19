//
// Created by makar on 10/19/22.
//

import UIKit

class GameScore: BaseStackView {

  private var playerScore = 0 { didSet { scoresChanged() } }
  private var secondPlayerScore = 0 { didSet { scoresChanged() } }
  private let selectedMode: SelectedMode

  // UI
  private let gameScoreContainer = BaseView()
  private let gameScoreLabel = UILabel()

  private let playerName = UILabel()
  private let secondPlayerName = UILabel()

  init(mode: SelectedMode) {
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

@objc extension GameScore {

  override func setViews() {
    super.setViews()

    addArrangedSubview(playerName)

    addArrangedSubview(gameScoreContainer)
    gameScoreContainer.setView(gameScoreLabel)

    addArrangedSubview(secondPlayerName)
  }

  override func setConstraints() {
    super.setConstraints()

    NSLayoutConstraint.activate([
      gameScoreContainer.heightAnchor.constraint(equalToConstant: 40),

      gameScoreLabel.centerXAnchor.constraint(equalTo: gameScoreContainer.centerXAnchor),
      gameScoreLabel.centerYAnchor.constraint(equalTo: gameScoreContainer.centerYAnchor)
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    setLayoutOptions(axis: .horizontal)

    playerName.text = "You"
    playerName.textColor = Colors.white
    playerName.textAlignment = .center
    playerName.font = Fonts.Custom.helveticaRegular(size: 24)

    secondPlayerName.text = selectedMode == .ai ? "AI" : "Friend"
    secondPlayerName.textColor = Colors.white
    secondPlayerName.textAlignment = .center
    secondPlayerName.font = Fonts.Custom.helveticaRegular(size: 24)

    gameScoreContainer.backgroundColor = Colors.white
    gameScoreContainer.setDefaultShadow()
    gameScoreContainer.layer.cornerRadius = 14

    gameScoreLabel.text = "\(playerScore) - \(secondPlayerScore)"
    gameScoreLabel.font = Fonts.Custom.helveticaBold(size: 24)
    gameScoreLabel.textAlignment = .center
    gameScoreLabel.textColor = Colors.black
  }

}
