//
// Created by makar on 10/19/22.
//

import UIKit

final class GameBoard: BaseView,
  UICollectionViewDelegate,
  UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout {

  private let gameManager: GameManager

  // UI
  private let containerView = BaseView()
  private let gameScore: GameScore
  private let boardContainerView = BaseView()
  private let board = Board(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

  init(mode: SelectedGameMode, side: SelectedSide) {
    gameScore = GameScore(mode: mode)
    gameManager = GameManager(
      isGameWithAi: mode == .ai,
      selectedSide: side,
      board: board,
      gameScore: gameScore
    )

    super.init(frame: .zero)
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = board.cellForItem(at: indexPath) as? BoardCell

    guard cell?.state == .empty && !gameManager.isGameOver else {
      return
    }

    gameManager.cellPressed(indexPath: indexPath)
  }

}

extension GameBoard {
  private func getCellSize() -> CGSize {
    CGSize(
      width: board.bounds.width / 3,
      height: board.bounds.width / 3
    )
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    3
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    3
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    getCellSize()
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    0
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    20
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    board.dequeueReusableCell(withReuseIdentifier: BoardCell.identifier, for: indexPath)
  }
}

extension GameBoard {

  override func setViews() {
    super.setViews()

    setView(containerView)

    containerView.setView(gameScore)

    boardContainerView.setView(board)
    containerView.setView(boardContainerView)
  }

  override func setConstraints() {
    super.setConstraints()

    let horizontalPadding: CGFloat = 10
    let boardPadding: CGFloat = 30

    NSLayoutConstraint.activate([
      containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
      containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding),
      containerView.topAnchor.constraint(equalTo: gameScore.topAnchor),
      containerView.bottomAnchor.constraint(equalTo: boardContainerView.bottomAnchor),

      gameScore.widthAnchor.constraint(equalTo: containerView.widthAnchor),
      gameScore.bottomAnchor.constraint(equalTo: boardContainerView.topAnchor, constant: -20),

      boardContainerView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
      boardContainerView.heightAnchor.constraint(equalTo: containerView.widthAnchor),

      board.leadingAnchor.constraint(equalTo: boardContainerView.leadingAnchor, constant: boardPadding),
      board.trailingAnchor.constraint(equalTo: boardContainerView.trailingAnchor, constant: -boardPadding),
      board.topAnchor.constraint(equalTo: boardContainerView.topAnchor, constant: boardPadding),
      board.bottomAnchor.constraint(equalTo: boardContainerView.bottomAnchor, constant: -boardPadding),
      board.centerXAnchor.constraint(equalTo: boardContainerView.centerXAnchor),
      board.centerYAnchor.constraint(equalTo: boardContainerView.centerYAnchor)
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    boardContainerView.backgroundColor = Colors.white
    boardContainerView.layer.cornerRadius = 20
    boardContainerView.setDefaultShadow()
    board.backgroundColor = Colors.white

    board.register(BoardCell.self, forCellWithReuseIdentifier: BoardCell.identifier)
    board.delegate = self
    board.dataSource = self
    board.isScrollEnabled = false
  }

}
