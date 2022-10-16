//
//  GameConfigurationViewController.swift
//  tic-tac-toe-ai-uikit
//
//  Created by makar on 10/16/22.
//

import UIKit

class GameConfigurationViewController: BaseViewController {

  private let marksStack = MarksView()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Choose your play mode"
    label.textColor = Colors.Text.primaryBlack
    label.font = Fonts.helveticaBold(size: 25)
    return label
  }()

}

extension GameConfigurationViewController {

  override func setViews() {
    super.setViews()

    view.setView(marksStack)
    view.setView(titleLabel)
  }

  override func setConstraints() {
    super.setConstraints()

    NSLayoutConstraint.activate([
      marksStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      marksStack.heightAnchor.constraint(equalToConstant: getMarksSize()),
      marksStack.widthAnchor.constraint(equalToConstant: getMarksSize() * 1.85),
      marksStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      titleLabel.topAnchor.constraint(equalTo: marksStack.bottomAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()

    marksStack.drawMarks(marksSize: getMarksSize())
  }

  private func getMarksSize() -> CGFloat {
    view.bounds.width / 2.4
  }

}
