//
// Created by makar on 10/21/22.
//

import UIKit

class BoardGrid: BaseMark, DrawableMarkProtocol {

  private func getLineLayer(from: CGPoint, to: CGPoint) -> CALayer {
    let linePath = UIBezierPath()
    linePath.move(to: from)
    linePath.addLine(to: to)

    let lineLayer = CAShapeLayer()
    lineLayer.path = linePath.cgPath
    lineLayer.fillColor = UIColor.clear.cgColor

    lineLayer.strokeColor = Colors.gray.cgColor
    lineLayer.lineWidth = 2
    lineLayer.lineCap = .round

    return lineLayer
  }

  func draw() {
    layer.sublayers?.removeAll()

    let gridLayer = CAShapeLayer()
    let acrossGridLayer = CAShapeLayer()

    (1...2).forEach { iteration in
      let isFirstLine = iteration > 1
      let from = isFirstLine
                 ? CGPoint(x: markerWidth / 3, y: 0)
                 : CGPoint(x: markerWidth / 3 * 2, y: 0)
      let to = isFirstLine
               ? CGPoint(x: markerWidth / 3, y: markerWidth)
               : CGPoint(x: markerWidth / 3 * 2, y: markerWidth)
      let line = getLineLayer(from: from, to: to)

      gridLayer.addSublayer(line)
    }

    (1...2).forEach { iteration in
      let isFirstLine = iteration > 1
      let from = isFirstLine
                 ? CGPoint(x: 0, y: markerWidth / 3)
                 : CGPoint(x: 0, y: markerWidth / 3 * 2)
      let to = isFirstLine
               ? CGPoint(x: markerWidth, y: markerWidth / 3)
               : CGPoint(x: markerWidth, y: markerWidth / 3 * 2)
      let line = getLineLayer(from: from, to: to)

      acrossGridLayer.addSublayer(line)
    }

    layer.addSublayer(gridLayer)
    layer.addSublayer(acrossGridLayer)

    setConstraintsConstant(width: markerWidth)
  }

}
