//
// Created by makar on 10/26/22.
//

import UIKit

protocol PlayersMovesProtocol: AnyObject {
  var playerMoves: [Int] { get set }
  var aiMoves: [Int] { get set }
}

final class AIOfGame {

  private(set) var WIN_POSITIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  private let gameProbability = AIGameProbability(initialDifficulty: .easy)

  weak var playersMovesDelegate: PlayersMovesProtocol?
  var playerMoves: [Int] { playersMovesDelegate?.playerMoves ?? [] }
  var aiMoves: [Int] { playersMovesDelegate?.aiMoves ?? [] }
  var composedMoves: [Int] { aiMoves + playerMoves }

  func getAiNextMove(completion: @escaping (Int) -> Void) {
    let aiThinkingTime = Double.random(in: 0.4...1.2)

    DispatchQueue.main.asyncAfter(deadline: .now() + aiThinkingTime) { [self] in
      // check is center cell occupied
      let centerCellIndex = 4
      let isCenterCellOccupied = composedMoves.contains { $0 == centerCellIndex }

      let isNeedTakeCenterCell = gameProbability.checkIsNeedAggressiveAttack()
      if !isCenterCellOccupied && isNeedTakeCenterCell {
        completion(centerCellIndex)
      }

      let (isWinningMove, move) = getAiMove()

      // prevent defeat
      let isNeedDefense = gameProbability.checkIsNeedSmartDefense()
      if !isWinningMove, isNeedDefense, let defencePosition = getAiMoveForDefense() {
        completion(defencePosition)
      }

      if let move = move {
        completion(move)
      }
    }
  }

  func aiHasWon() {
    gameProbability.aiHasWon()
  }

  func playerHasWon() {
    gameProbability.opponentHasWon()
  }

}

extension AIOfGame {

  private func getAiMove() -> (Bool, Int?) {
    let availablePositions = WIN_POSITIONS.filter { positions in
      Set(positions).subtracting(Set(playerMoves)).count == 3
    }

    let winningPositions = availablePositions
    .first(where: { positions in
      Set(positions).subtracting(Set(aiMoves)).count < 2
    })

    let goodPositions = availablePositions
    .first(where: { positions in
      Set(positions).subtracting(Set(aiMoves)).count == 2
    })

    let emptyAvailableCells = [
      Array(
        Set(WIN_POSITIONS.joined()).subtracting(Set(playerMoves + aiMoves))
      )
    ]
    let randomPositions = availablePositions.isEmpty
                          ? emptyAvailableCells[Int.random(in: 0...emptyAvailableCells.count - 1)]
                          : availablePositions[Int.random(in: 0...availablePositions.count - 1)]

    let isWinningMove = winningPositions != nil
    let move = Set(winningPositions ?? goodPositions ?? randomPositions).subtracting(Set(aiMoves)).first

    return (isWinningMove, move)
  }

  private func getAiMoveForDefense() -> Int? {
    let lastChanceMovePositions = WIN_POSITIONS.filter { positions in
      Set(positions).subtracting(Set(composedMoves)).count == 1
    }

    let winningPositions = lastChanceMovePositions.first(where: { positions in
      Set(positions).subtracting(Set(aiMoves)).count == 3
    })

    return Set(winningPositions ?? playerMoves).subtracting(Set(playerMoves)).first
  }

}
