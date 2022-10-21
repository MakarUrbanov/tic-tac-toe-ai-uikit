//
// Created by makar on 10/19/22.
//

import UIKit

final class GameBoard: BaseView,
  UICollectionViewDelegate,
  UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout {

  let selectedGameMode: SelectedGameMode
  var whoseMove: SelectedSide

  let horizontalPadding: CGFloat = 10
  let boardPadding: CGFloat = 30

  private let containerView = BaseView()
  private let gameScore: GameScore
  private let boardContainerView = BaseView()
  private let board = Board(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

  init(mode: SelectedGameMode, side: SelectedSide) {
    gameScore = GameScore(mode: mode)
    selectedGameMode = mode
    whoseMove = side

    super.init(frame: .zero)
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    gameScore.frame = bounds
  }
}

extension GameBoard {
  func onCrossPressed(cell: BoardCell?, indexPath: IndexPath) {
    cell?.setMark(.cross)
  }

  func onNoughtPressed(cell: BoardCell?, indexPath: IndexPath) {
    cell?.setMark(.nought)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = board.cellForItem(at: indexPath) as? BoardCell

    if cell?.state == .empty {
      switch whoseMove {
        case .cross:
          onCrossPressed(cell: cell, indexPath: indexPath)
          whoseMove = .nought
        case .nought:
          onNoughtPressed(cell: cell, indexPath: indexPath)
          whoseMove = .cross
      }

      gameScore.changeTurn()
    }
  }
}

extension GameBoard {
  private func getCellSize() -> CGSize {
    CGSize(
      width: frame.width / 3 - horizontalPadding / 1.5 - boardPadding / 1.5,
      height: frame.width / 3 - horizontalPadding / 1.5 - boardPadding / 1.5
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
