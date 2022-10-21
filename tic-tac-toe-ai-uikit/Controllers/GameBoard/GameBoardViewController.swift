//
// Created by makar on 10/16/22.
//

import UIKit

final class GameBoardViewController: BaseViewController {

  private let selectedMode: SelectedGameMode
  private let selectedSide: SelectedSide

  private let gameBoard: GameBoard

  init(mode: SelectedGameMode, side: SelectedSide) {
    selectedMode = mode
    selectedSide = side
    gameBoard = GameBoard(mode: mode, side: side)

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

    let paddingVertical = view.frame.height * 0.1

    NSLayoutConstraint.activate([
      gameBoard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      gameBoard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: paddingVertical),
      gameBoard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      gameBoard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -paddingVertical)
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()
  }

}
