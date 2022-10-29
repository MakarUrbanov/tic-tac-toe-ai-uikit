//
// Created by makar on 10/27/22.
//

import UIKit

final class GameManager: PlayersMovesProtocol {
  private let gameAi = AIOfGame()
  private let selectedFirstPlayerSide: SelectedSide
  private var currentMoveFor: CurrentMoveFor = .firstPlayer
  private let board: Board
  private let gameScore: GameScore

  var playerMoves: [Int] = [] { didSet { checkGameOverHandler() } }
  var aiMoves: [Int] = [] { didSet { checkGameOverHandler() } }
  var isGameOver = false
  let isGameWithAi: Bool

  init(
    isGameWithAi: Bool,
    selectedSide: SelectedSide,
    board: Board,
    gameScore: GameScore
  ) {
    self.isGameWithAi = isGameWithAi
    selectedFirstPlayerSide = selectedSide
    self.board = board
    self.gameScore = gameScore

    gameAi.playersMovesDelegate = self
  }

  func cellPressed(indexPath: IndexPath) {
    switch currentMoveFor {
      case .firstPlayer:
        onFirstPlayerMove(indexPath: indexPath)
      case .secondPlayer:
        onSecondPlayerMove(indexPath: indexPath)
    }
  }

}

extension GameManager { // MOVES
  private func setPlayerMove(indexPath: IndexPath) {
    let cell = board.cellForItem(at: indexPath) as? BoardCell
    let mark: BoardCellState = selectedFirstPlayerSide == .cross ? .cross : .nought
    cell?.setMark(mark)
    playerMoves.append(GameManager_utils.getMoveIntFromIndexPath(indexPath))
  }

  private func setSecondPlayerMove(indexPath: IndexPath) {
    let cell = board.cellForItem(at: indexPath) as? BoardCell
    let mark: BoardCellState = selectedFirstPlayerSide == .cross ? .nought : .cross
    cell?.setMark(mark)
    aiMoves.append(GameManager_utils.getMoveIntFromIndexPath(indexPath))
  }

  private func setAiMove(nextMove: Int) {
    let indexPath = GameManager_utils.getIndexPathFromInt(nextMove)
    setSecondPlayerMove(indexPath: indexPath)
    setNextMoveOptions()
  }

  private func onFirstPlayerMove(indexPath: IndexPath) {
    setPlayerMove(indexPath: indexPath)

    let isDraw = gameAi.composedMoves.count == 9

    if !isDraw {
      setNextMoveOptions()
    }

    if isGameWithAi && !isDraw && !isGameOver {
      gameAi.getAiNextMove { [self] nextMove in
        setAiMove(nextMove: nextMove)
      }
    }
  }

  private func onSecondPlayerMove(indexPath: IndexPath) {
    if isGameWithAi {
      return
    }

    setSecondPlayerMove(indexPath: indexPath)
    setNextMoveOptions()
  }
}

extension GameManager { // ON GAME OVER
  private func restartGame() {
    currentMoveFor = .firstPlayer
    playerMoves = []
    aiMoves = []
    isGameOver = false
    board.refreshCells()
    gameScore.changeTurn(.firstPlayer)
  }

  private func setNewScore(winner: Winner) {
    let playerScore = gameScore.playerScore + (winner == .player ? 1 : 0)
    let secondPlayerScore = gameScore.secondPlayerScore + (winner == .secondPlayer ? 1 : 0)
    gameScore.setScore(playerScore, secondPlayerScore)
  }

  private func checkGameOverHandler() {
    let winner = GameManager_utils.checkWhoWon(
      WIN_POSITIONS: gameAi.WIN_POSITIONS,
      playerMoves: playerMoves,
      aiMoves: aiMoves
    )

    if !isGameOver, let whoWon = winner {
      isGameOver = true
      setNewScore(winner: whoWon)
    }
  }
}

extension GameManager {
  private func setNextMoveOptions() {
    gameScore.changeTurn()
    currentMoveFor = currentMoveFor == .firstPlayer ? .secondPlayer : .firstPlayer
  }
}
