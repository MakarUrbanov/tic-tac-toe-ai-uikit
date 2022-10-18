//
// Created by makar on 10/16/22.
//

import UIKit

final class GameBoardViewController: BaseViewController {

  private let selectedMode: SelectedMode
  private let selectedSide: SelectedSide

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Pick your side"
    return label
  }()

  init(mode: SelectedMode, side: SelectedSide) {
    selectedMode = mode
    selectedSide = side

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension GameBoardViewController {

  override func setViews() {
    super.setViews()

    view.setView(titleLabel)
  }

  override func setConstraints() {
    super.setConstraints()

    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()
  }

}
