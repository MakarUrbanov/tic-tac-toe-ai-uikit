//
// Created by makar on 10/19/22.
//

import UIKit

class GameBoard: BaseStackView {

  private let gameScore: GameScore

  init(mode: SelectedMode) {
    gameScore = GameScore(mode: mode)

    super.init(frame: .zero)
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension GameBoard {

  override func setViews() {
    super.setViews()

    addArrangedSubview(gameScore)
  }

  override func setConstraints() {
    super.setConstraints()

    NSLayoutConstraint.activate([
      gameScore.widthAnchor.constraint(equalTo: widthAnchor)
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    setLayoutOptions(axis: .vertical)
  }

}
