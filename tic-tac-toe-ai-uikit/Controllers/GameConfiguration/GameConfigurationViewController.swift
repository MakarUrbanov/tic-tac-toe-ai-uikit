//
//  GameConfigurationViewController.swift
//  tic-tac-toe-ai-uikit
//
//  Created by makar on 10/16/22.
//

import UIKit

class GameConfigurationViewController: BaseViewController {

  private let xMark = XMark()

  private func getXMarkSize() -> CGFloat {
    view.bounds.width / 2
  }

}

extension GameConfigurationViewController {

  override func setViews() {
    super.setViews()

    view.setView(xMark)
  }

  override func setConstraints() {
    super.setConstraints()

    NSLayoutConstraint.activate([
      xMark.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      xMark.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      xMark.widthAnchor.constraint(equalToConstant: getXMarkSize()),
      xMark.heightAnchor.constraint(equalToConstant: getXMarkSize())
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    xMark.draw(width: getXMarkSize())
  }

}
