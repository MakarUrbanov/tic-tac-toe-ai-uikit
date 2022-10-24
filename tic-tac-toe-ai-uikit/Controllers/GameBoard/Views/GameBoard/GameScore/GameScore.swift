//
// Created by makar on 10/19/22.
//

import UIKit

class GameScore: BaseView {

  private(set) var playerScore = 0 { didSet { scoresChanged() } }
  private(set) var secondPlayerScore = 0 { didSet { scoresChanged() } }
  private let selectedMode: SelectedGameMode

  // UI
  private var userInterfaceStyle: UIUserInterfaceStyle {
    traitCollection.userInterfaceStyle
  }

  private let gameScoreContainer = BaseView()
  private let gameScoreLabel = UILabel()

  private let playerName = UILabel()
  private let playerNameColorInverted = UILabel()
  private let secondPlayerName = UILabel()
  private let secondPlayerNameColorInverted = UILabel()

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

  private func changeColorsBasedOnUserInterfaceStyle() {
    let isDarkMode = userInterfaceStyle == .dark
    gameScoreContainer.backgroundColor = isDarkMode ? Colors.white : Colors.activeButton
    selectorLine.backgroundColor = isDarkMode ? Colors.white : Colors.activeButton

    gameScoreLabel.textColor = isDarkMode ? Colors.black : Colors.white
    playerName.textColor = isDarkMode ? Colors.white : Colors.black
    playerNameColorInverted.textColor = isDarkMode ? Colors.black : Colors.white
    secondPlayerName.textColor = isDarkMode ? Colors.white : Colors.black
    secondPlayerNameColorInverted.textColor = isDarkMode ? Colors.black : Colors.white
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    changeColorsBasedOnUserInterfaceStyle()
  }

}

extension GameScore {

  func setScore(_ firstPlayer: Int, _ secondsPlayer: Int) {
    playerScore = firstPlayer
    secondPlayerScore = secondsPlayer
  }

  enum WhoseTurn {
    case firstPlayer, secondsPlayer
  }

  func changeTurn(_ whosoTurn: WhoseTurn? = nil) {
    let isSecondPlayerMove = whosoTurn != nil ? whosoTurn == .secondsPlayer : selectorLine.transform.tx == 0
    let yTranslate = isSecondPlayerMove ? secondPlayerName.frame.maxX - playerName.bounds.width : 0

    UIView.animate(
      withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0) { [self] in
      selectorLine.transform = isSecondPlayerMove
      ? CGAffineTransformMakeTranslation(yTranslate, 0)
      : CGAffineTransformMakeTranslation(0, 0)

      selectorLine.subviews.forEach { (view: UIView) in
        view.transform = isSecondPlayerMove
        ? CGAffineTransformMakeTranslation(-yTranslate, 0)
        : CGAffineTransformMakeTranslation(0, 0)
      }
    }
  }

}

@objc extension GameScore {

  override func setViews() {
    super.setViews()

    setView(playerName)

    gameScoreContainer.setView(gameScoreLabel)
    setView(gameScoreContainer)

    setView(secondPlayerName)

    selectorLine.setView(playerNameColorInverted)
    selectorLine.setView(secondPlayerNameColorInverted)
    setView(selectorLine)
  }

  override func setConstraints() {
    super.setConstraints()

    NSLayoutConstraint.activate([
      playerName.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / 3),
      playerName.heightAnchor.constraint(equalToConstant: 40),
      playerName.leadingAnchor.constraint(equalTo: leadingAnchor),
      playerName.bottomAnchor.constraint(equalTo: bottomAnchor),
      playerName.centerYAnchor.constraint(equalTo: centerYAnchor),

      gameScoreContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / 3),
      gameScoreContainer.heightAnchor.constraint(equalToConstant: 40),
      gameScoreContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
      gameScoreContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
      gameScoreContainer.centerYAnchor.constraint(equalTo: centerYAnchor),

      gameScoreLabel.centerXAnchor.constraint(equalTo: gameScoreContainer.centerXAnchor),
      gameScoreLabel.centerYAnchor.constraint(equalTo: gameScoreContainer.centerYAnchor),

      secondPlayerName.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / 3),
      secondPlayerName.heightAnchor.constraint(equalToConstant: 40),
      secondPlayerName.trailingAnchor.constraint(equalTo: trailingAnchor),
      secondPlayerName.centerYAnchor.constraint(equalTo: centerYAnchor),

      selectorLine.widthAnchor.constraint(equalTo: playerName.widthAnchor, multiplier: 0.8),
      selectorLine.heightAnchor.constraint(equalToConstant: 40),
      selectorLine.centerXAnchor.constraint(equalTo: playerName.centerXAnchor),
      selectorLine.centerYAnchor.constraint(equalTo: playerName.centerYAnchor),

      playerNameColorInverted.centerXAnchor.constraint(equalTo: playerName.centerXAnchor),
      playerNameColorInverted.centerYAnchor.constraint(equalTo: playerName.centerYAnchor),

      secondPlayerNameColorInverted.centerXAnchor.constraint(equalTo: secondPlayerName.centerXAnchor),
      secondPlayerNameColorInverted.centerYAnchor.constraint(equalTo: secondPlayerName.centerYAnchor)
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    [playerName, playerNameColorInverted].forEach { (label: UILabel) in
      label.text = "You"
      label.textAlignment = .center
      label.font = Fonts.Custom.helveticaRegular(size: 24)
    }
    playerName.layer.zPosition = 1
    playerNameColorInverted.layer.zPosition = 2

    [secondPlayerName, secondPlayerNameColorInverted].forEach { (label: UILabel) in
      label.text = selectedMode == .ai ? "AI" : "Friend"
      label.textAlignment = .center
      label.font = Fonts.Custom.helveticaRegular(size: 24)
    }
    secondPlayerName.layer.zPosition = 1
    secondPlayerNameColorInverted.layer.zPosition = 2

    gameScoreContainer.setDefaultShadow()
    gameScoreContainer.layer.cornerRadius = 14
    gameScoreContainer.layer.zPosition = 4

    gameScoreLabel.text = "\(playerScore) - \(secondPlayerScore)"
    gameScoreLabel.font = Fonts.Custom.helveticaBold(size: 24)
    gameScoreLabel.textAlignment = .center

    selectorLine.layer.zPosition = 3
    selectorLine.layer.cornerRadius = 14
    selectorLine.setDefaultShadow()
    selectorLine.clipsToBounds = true

    changeColorsBasedOnUserInterfaceStyle()
  }

}
