//
// Created by makar on 10/26/22.
//

import UIKit

class AIGameProbability {

  enum InitialProbability: Double {
    case easy = 0.3
    case normal = 0.5
    case hard = 0.65
  }

  private var winsOfAi: Int = 0
  private var winsOfOpponent: Int = 0

  private let initialDifficulty: InitialProbability
  private var probability: Double {
    Double.minimum(initialDifficulty.rawValue + getProbabilityMultiplier(), 1)
  }

  init(initialDifficulty: InitialProbability) {
    self.initialDifficulty = initialDifficulty
  }

  func aiHasWon() {
    winsOfAi += 1
  }

  func opponentHasWon() {
    winsOfOpponent += 1
  }

  func checkIsNeedAggressiveAttack() -> Bool {
    Double.random(in: 0...1) <= probability
  }

  func checkIsNeedSmartDefense() -> Bool {
    Double.random(in: 0...1) <= probability
  }

}

extension AIGameProbability {

  private func getProbabilityMultiplier() -> Double {
    let differenceInTheScore = Double(winsOfOpponent - winsOfAi)

    switch initialDifficulty {
      case .easy:
        return 0.1 * differenceInTheScore
      case .normal, .hard:
        return 0.15 * differenceInTheScore
    }
  }

}
