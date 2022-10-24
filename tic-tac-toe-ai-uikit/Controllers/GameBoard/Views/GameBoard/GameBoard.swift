//
// Created by makar on 10/19/22.
//

import UIKit

final class GameBoard: BaseView,
  UICollectionViewDelegate,
  UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout {

  private enum CurrentMoveFor {
    case firstPlayer, secondPlayer
  }

  private let isGameWithAi: Bool
  private let WIN_POSITIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  private let selectedFirstPlayerSide: SelectedSide
  private var currentMoveFor: CurrentMoveFor = .firstPlayer
  private var playerMoves: [Int] = [] { didSet { checkGameOverHandler() } }
  private var secondPlayerMoves: [Int] = [] { didSet { checkGameOverHandler() } }
  private var isGameOver = false

  // UI
  private let containerView = BaseView()
  private let gameScore: GameScore
  private let boardContainerView = BaseView()
  private let board = Board(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

  init(mode: SelectedGameMode, side: SelectedSide) {
    gameScore = GameScore(mode: mode)
    isGameWithAi = mode == .ai
    selectedFirstPlayerSide = side

    super.init(frame: .zero)
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension GameBoard {

  private func setPlayerMove(indexPath: IndexPath) {
    let cell = board.cellForItem(at: indexPath) as? BoardCell
    let mark: BoardCellState = selectedFirstPlayerSide == .cross ? .cross : .nought
    cell?.setMark(mark)
    let moveIndex = indexPath.row + indexPath.section * 3
    playerMoves.append(moveIndex)
  }

  private func setSecondPlayerMove(indexPath: IndexPath) {
    let cell = board.cellForItem(at: indexPath) as? BoardCell
    let mark: BoardCellState = selectedFirstPlayerSide == .cross ? .nought : .cross
    cell?.setMark(mark)
    let moveIndex = indexPath.row + indexPath.section * 3
    secondPlayerMoves.append(moveIndex)
  }

  private func setNextMoveOptions() {
    gameScore.changeTurn()
    currentMoveFor = currentMoveFor == .firstPlayer ? .secondPlayer : .firstPlayer
  }

  private func getIndexPathFromInt(_ position: Int) -> IndexPath {
    let row = position % 3
    let section = position / 3
    return IndexPath(row: row, section: section)
  }

  private func getAiMoveForDefense() -> Int? {
    let composedMoves = playerMoves + secondPlayerMoves

    let lastChanceMovePositions = WIN_POSITIONS
    .filter { positions in
      Set(positions).subtracting(Set(composedMoves)).count == 1
    }

    let winningPositions = lastChanceMovePositions
    .first(where: { positions in
      Set(positions).subtracting(Set(secondPlayerMoves)).count == 3
    })

    return Set(winningPositions ?? playerMoves).subtracting(Set(playerMoves)).first
  }

  private func getAiMove() -> (Bool, Int?) {
    let availablePositions = WIN_POSITIONS.filter { positions in
      Set(positions).subtracting(Set(playerMoves)).count == 3
    }

    let winningPositions = availablePositions
    .first(where: { positions in
      Set(positions).subtracting(Set(secondPlayerMoves)).count < 2
    })

    let goodPositions = availablePositions
    .first(where: { positions in
      Set(positions).subtracting(Set(secondPlayerMoves)).count == 2
    })

    let emptyAvailableCells = [Array(Set(WIN_POSITIONS.joined()).subtracting(Set(playerMoves + secondPlayerMoves)))]
    let randomPositions = availablePositions.isEmpty
                          ? emptyAvailableCells[Int.random(in: 0...emptyAvailableCells.count - 1)]
                          : availablePositions[Int.random(in: 0...availablePositions.count - 1)]

    let isWinningMove = winningPositions != nil
    let move = Set(winningPositions ?? goodPositions ?? randomPositions).subtracting(Set(secondPlayerMoves)).first

    return (isWinningMove, move)
  }

  private func onAiMove() {
    let aiThinkingTime = Double.random(in: 0.4...1.2)

    DispatchQueue.main.asyncAfter(deadline: .now() + aiThinkingTime) { [self] in
      let composedMoves = playerMoves + secondPlayerMoves
      setNextMoveOptions()

      // check is center cell occupied
      let isCenterCellOccupied = composedMoves.contains(where: { (move: Int) in
        move == 4
      })
      if !isCenterCellOccupied {
        setSecondPlayerMove(indexPath: getIndexPathFromInt(4))
        return
      }

      let (isWinningMove, move) = getAiMove()

      // prevent defeat
      if !isWinningMove, let defencePosition = getAiMoveForDefense() {
        setSecondPlayerMove(indexPath: getIndexPathFromInt(defencePosition))

        return
      }

      if let move = move {
        setSecondPlayerMove(indexPath: getIndexPathFromInt(move))
      }
    }
  }

  private func onFirstPlayerMove(indexPath: IndexPath) {
    setPlayerMove(indexPath: indexPath)

    let isDraw = (playerMoves + secondPlayerMoves).count == 9

    if !isDraw {
      setNextMoveOptions()
    }

    if isGameWithAi && !isDraw && !isGameOver {
      onAiMove()
    }
  }

  private func onSecondPlayerMove(indexPath: IndexPath) {
    if isGameWithAi {
      return
    }

    setSecondPlayerMove(indexPath: indexPath)
    setNextMoveOptions()
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = board.cellForItem(at: indexPath) as? BoardCell

    guard cell?.state == .empty && !isGameOver else {
      return
    }

    switch currentMoveFor {
      case .firstPlayer:
        onFirstPlayerMove(indexPath: indexPath)
      case .secondPlayer:
        onSecondPlayerMove(indexPath: indexPath)
    }
  }

  private func restartGame() {
    currentMoveFor = .firstPlayer
    playerMoves = []
    secondPlayerMoves = []
    isGameOver = false
    board.refreshCells()
    gameScore.changeTurn(.firstPlayer)
  }

  private enum WhoWon {
    case player, secondPlayer, draw
  }

  private func getAlertMessage(whoWon: WhoWon) -> String {
    switch whoWon {
      case .player:
        return "You have won\nCongratulations"
      case .secondPlayer:
        return isGameWithAi ? "Ai have won\nGood luck in the next game!" : "Your friend have won\nCongratulations"
      case .draw:
        return "Draw!"
    }
  }

  private func invokeAlert(whoWon: WhoWon) {
    let message = getAlertMessage(whoWon: whoWon)
    let alert = AlertManager(title: "Game Over", message: message)
    .addActionButton(title: "Restart", style: .default) { [unowned self] _ in
      restartGame()
    }
    let viewController = getCurrentViewController()
    viewController?.present(alert, animated: true, completion: nil)
  }

  private func setNewScore(whoWon: WhoWon) {
    let playerScore = gameScore.playerScore + (whoWon == .player ? 1 : 0)
    let secondPlayerScore = gameScore.secondPlayerScore + (whoWon == .secondPlayer ? 1 : 0)
    gameScore.setScore(playerScore, secondPlayerScore)
  }

  private func checkGameOverHandler() {
    let isPlayerWon = WIN_POSITIONS.first { positions in
      Set(positions).subtracting(Set(playerMoves)).isEmpty
    } != nil
    let isSecondPlayerWon = WIN_POSITIONS.first { positions in
      Set(positions).subtracting(Set(secondPlayerMoves)).isEmpty
    } != nil
    let isDraw = (playerMoves + secondPlayerMoves).count == 9

    if (isPlayerWon || isSecondPlayerWon || isDraw) && !isGameOver {
      isGameOver = true
      let whoWon: WhoWon = isPlayerWon ? .player : isSecondPlayerWon ? .secondPlayer : .draw
      invokeAlert(whoWon: whoWon)
      setNewScore(whoWon: whoWon)
    }
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
