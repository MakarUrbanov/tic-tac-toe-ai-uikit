//
// Created by makar on 10/26/22.
//

import UIKit

final class AIOfGame {

  private let gameProbability = AIGameProbability(initialDifficulty: .easy)
  private let playersMoves = AIPlayersMoves()

  func getAiNextMove() -> Int {
    let aiThinkingTime = Double.random(in: 0.4...1.2)

    DispatchQueue.main.asyncAfter(deadline: .now() + aiThinkingTime) { [self] in
      let composedMoves = playersMoves.opponentMoves + playersMoves.aiMoves

      // check is center cell occupied
      let centerCellIndex = 4
      let isCenterCellOccupied = composedMoves.contains { $0 == centerCellIndex }

      let isNeedTakeCenterCell = gameProbability.checkIsNeedAggressiveAttack()
      if !isCenterCellOccupied && isNeedTakeCenterCell {
        return 4
      }

      let (isWinningMove, move) = getAiMove()

      // prevent defeat
      let isNeedDefense = gameProbability.checkIsNeedSmartDefense()
      if !isWinningMove, isNeedDefense, let defencePosition = getAiMoveForDefense() {
        return defencePosition
      }

      if let move = move {
        return move
      }
    }
  }

  func restartGame() {
    playersMoves.refreshMoves()
  }

  func aiHasWon() {
    gameProbability.aiHasWon()
  }

  func playerHasWon() {
    gameProbability.opponentHasWon()
  }

  func setAiMove(cellNumber: Int) {
    playersMoves.setAIMove(cellIndex: cellNumber)
  }

  func setPlayerMove(cellNumber: Int) {
    playersMoves.setOpponentMove(cellIndex: cellNumber)
  }

}

extension AIOfGame {

  private func getAiMove() -> (Bool, Int?) {
    let availablePositions = playersMoves.WIN_POSITIONS.filter { positions in
      Set(positions).subtracting(Set(playersMoves.opponentMoves)).count == 3
    }

    let winningPositions = availablePositions
    .first(where: { positions in
      Set(positions).subtracting(Set(playersMoves.aiMoves)).count < 2
    })

    let goodPositions = availablePositions
    .first(where: { positions in
      Set(positions).subtracting(Set(playersMoves.aiMoves)).count == 2
    })

    let emptyAvailableCells = [
      Array(
        Set(playersMoves.WIN_POSITIONS.joined()).subtracting(Set(playersMoves.opponentMoves + playersMoves.aiMoves))
      )
    ]
    let randomPositions = availablePositions.isEmpty
                          ? emptyAvailableCells[Int.random(in: 0...emptyAvailableCells.count - 1)]
                          : availablePositions[Int.random(in: 0...availablePositions.count - 1)]

    let isWinningMove = winningPositions != nil
    let move = Set(winningPositions ?? goodPositions ?? randomPositions).subtracting(Set(playersMoves.aiMoves)).first

    return (isWinningMove, move)
  }

  private func getAiMoveForDefense() -> Int? {
    let composedMoves = playersMoves.aiMoves + playersMoves.opponentMoves

    let lastChanceMovePositions = playersMoves.WIN_POSITIONS.filter { positions in
      Set(positions).subtracting(Set(composedMoves)).count == 1
    }

    let winningPositions = lastChanceMovePositions.first(where: { positions in
      Set(positions).subtracting(Set(playersMoves.aiMoves)).count == 3
    })

    return Set(winningPositions ?? playersMoves.opponentMoves).subtracting(Set(playersMoves.opponentMoves)).first
  }

}
