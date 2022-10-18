//
// Created by makar on 10/16/22.
//

import UIKit

final class GameBoardViewController: BaseViewController {

  private let selectedMode: SelectedMode
  private let selectedSide: SelectedSide

  private let gameBoard: GameBoard

  init(mode: SelectedMode, side: SelectedSide) {
    selectedMode = mode
    selectedSide = side
    gameBoard = GameBoard(mode: mode)

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension GameBoardViewController {

  override func setViews() {
    super.setViews()

    view.setView(gameBoard)
  }

  override func setConstraints() {
    super.setConstraints()

    NSLayoutConstraint.activate([
      gameBoard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      gameBoard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      gameBoard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      gameBoard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()
  }

}
