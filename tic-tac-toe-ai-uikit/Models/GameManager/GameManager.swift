//
// Created by makar on 10/27/22.
//

import UIKit

protocol GameOverProtocol: AnyObject {
  func setGameOver(message: String)
}

final class GameManager: PlayersMovesProtocol {
  private let gameAi = AIOfGame()
  private let selectedFirstPlayerSide: SelectedSide
  private let board: Board
  private let gameScore: GameScore

  private var firstMoveFor: CurrentMoveFor = .firstPlayer
  private var currentMoveFor: CurrentMoveFor = .firstPlayer

  var playerMoves: [Int] = [] { didSet { checkGameOverHandler() } }
  var aiMoves: [Int] = [] { didSet { checkGameOverHandler() } }
  var isGameOver = false
  let isGameWithAi: Bool

  weak var gameOverDelegate: GameOverProtocol?

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

  func restartGame() {
    playerMoves = []
    aiMoves = []
    isGameOver = false
    board.refreshCells()
    firstMoveFor = firstMoveFor == .firstPlayer ? .secondPlayer : .firstPlayer
    currentMoveFor = firstMoveFor
    gameScore.changeTurn(firstMoveFor)

    let isAiCurrentTurn = isGameWithAi && (firstMoveFor == .secondPlayer)
    if isAiCurrentTurn {
      gameAi.getAiNextMove { [self] nextMove in
        setAiMove(nextMove: nextMove)
      }
    }
  }

}

extension GameManager { // MOVES
  private func setPlayerMove(indexPath: IndexPath) {
    let cell = board.cellForItem(at: indexPath) as? BoardCell
    let mark: BoardCellState = selectedFirstPlayerSide == .cross ? .cross : .nought
    cell?.setMark(mark)
    playerMoves.append(GameManager_utils.getMoveIntFromIndexPath(indexPath))
    setNextMoveOptions()
  }

  private func setSecondPlayerMove(indexPath: IndexPath) {
    let cell = board.cellForItem(at: indexPath) as? BoardCell
    let mark: BoardCellState = selectedFirstPlayerSide == .cross ? .nought : .cross
    cell?.setMark(mark)
    aiMoves.append(GameManager_utils.getMoveIntFromIndexPath(indexPath))
    setNextMoveOptions()
  }

  private func setAiMove(nextMove: Int) {
    let indexPath = GameManager_utils.getIndexPathFromInt(nextMove)
    setSecondPlayerMove(indexPath: indexPath)
  }

  private func onFirstPlayerMove(indexPath: IndexPath) {
    setPlayerMove(indexPath: indexPath)

    if isGameWithAi && !isGameOver {
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
  }
}

extension GameManager { // ON GAME OVER
  private func setNewScore(winner: Winner) {
    let playerScore = gameScore.playerScore + (winner == .player ? 1 : 0)
    let secondPlayerScore = gameScore.secondPlayerScore + (winner == .secondPlayer ? 1 : 0)
    gameScore.setScore(playerScore, secondPlayerScore)
  }

  private func setWinnerForAi(winner: Winner) {
    switch winner {
      case .player:
        gameAi.playerHasWon()
      case .secondPlayer:
        gameAi.aiHasWon()
      case .draw:
        return
    }
  }

  private func getGameOverMessage(winner: Winner) -> String {
    switch winner {
      case .player:
        return "You have won"
      case .secondPlayer:
        return isGameWithAi ? "Ai have won" : "Your friend have won"
      case .draw:
        return "Draw"
    }
  }

  private func setGameOverOptions(winner: Winner) {
    isGameOver = true
    setNewScore(winner: winner)
    setWinnerForAi(winner: winner)
    gameOverDelegate?.setGameOver(message: getGameOverMessage(winner: winner))
  }

  private func checkGameOverHandler() {
    let winner = GameManager_utils.checkWhoWon(
      WIN_POSITIONS: gameAi.WIN_POSITIONS,
      playerMoves: playerMoves,
      aiMoves: aiMoves
    )

    if !isGameOver, let winner = winner {
      setGameOverOptions(winner: winner)
    }
  }
}

extension GameManager {
  private func setNextMoveOptions() {
    gameScore.changeTurn()
    currentMoveFor = currentMoveFor == .firstPlayer ? .secondPlayer : .firstPlayer
  }
}
