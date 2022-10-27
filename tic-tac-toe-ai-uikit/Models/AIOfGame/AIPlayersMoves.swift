//
// Created by makar on 10/26/22.
//

import UIKit

class AIPlayersMoves {

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

  private(set) var aiMoves: [Int] = []
  private(set) var opponentMoves: [Int] = []

  func setAIMove(cellIndex: Int) {
    aiMoves.append(cellIndex)
  }

  func setOpponentMove(cellIndex: Int) {
    opponentMoves.append(cellIndex)
  }

  func refreshMoves() {
    aiMoves = []
    opponentMoves = []
  }

}
