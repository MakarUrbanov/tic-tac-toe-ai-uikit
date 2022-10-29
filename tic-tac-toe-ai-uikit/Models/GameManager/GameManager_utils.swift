//
// Created by makar on 10/30/22.
//

import UIKit

extension GameManager {
  enum GameManager_utils {

    static func checkWhoWon(WIN_POSITIONS: [[Int]], playerMoves: [Int], aiMoves: [Int]) -> Winner? {
      let isPlayerWon = WIN_POSITIONS.first { positions in
        Set(positions).subtracting(Set(playerMoves)).isEmpty
      } != nil
      let isSecondPlayerWon = WIN_POSITIONS.first { positions in
        Set(positions).subtracting(Set(aiMoves)).isEmpty
      } != nil
      let isDraw = (playerMoves + aiMoves).count == 9

      switch true {
        case isPlayerWon:
          return Winner.player
        case isSecondPlayerWon:
          return Winner.secondPlayer
        case isDraw:
          return Winner.draw
        default:
          return nil
      }
    }

    static func getIndexPathFromInt(_ position: Int) -> IndexPath {
      let row = position % 3
      let section = position / 3
      return IndexPath(row: row, section: section)
    }

    static func getMoveIntFromIndexPath(_ indexPath: IndexPath) -> Int {
      indexPath.row + indexPath.section * 3
    }

  }
}
