//
// Created by makar on 10/21/22.
//

import UIKit

class Board: UICollectionView {

  private let grid = BoardGrid(width: 0, withShadow: false)
  private var isGridSet = false

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)

    setViews()
    setConstraints()
    setAppearanceConfiguration()
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    if !isGridSet {
      grid.setNewMarkerWidth(bounds.width)
      grid.draw()

      isGridSet = true
    }
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  func refreshCells() {
    let cells = visibleCells as? [BoardCell]
    cells?.forEach { $0.refreshCell() }
  }

}

extension Board {

  func setViews() {
    setView(grid)
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      grid.centerXAnchor.constraint(equalTo: centerXAnchor),
      grid.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }

  func setAppearanceConfiguration() {
    grid.isUserInteractionEnabled = false
    layer.masksToBounds = false
  }

}
