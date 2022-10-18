//
// Created by makar on 10/16/22.
//

import UIKit

final class Cross: BaseMark, DrawableMarkProtocol {

  func draw() {
    let linesLayer = CAShapeLayer()

    // Draw lines
    let firstLineLayer = getLineLayer(
      from: CGPoint(x: markerWidth - reductionValue, y: reductionValue),
      to: CGPoint(x: reductionValue, y: markerWidth - reductionValue),
      lineWidth: lineWidth
    )
    let secondLineLayer = getLineLayer(
      from: CGPoint(x: reductionValue, y: reductionValue),
      to: CGPoint(x: markerWidth - reductionValue, y: markerWidth - reductionValue),
      lineWidth: lineWidth
    )

    linesLayer.addSublayer(firstLineLayer)
    linesLayer.addSublayer(secondLineLayer)

    let gradientLayer = getGradient(
      colorFrom: Colors.Gradients.Cross.from.cgColor,
      colorTo: Colors.Gradients.Cross.to.cgColor,
      on: linesLayer
    )

    let shadowLayer = getShadow(
      colorFrom: Colors.Gradients.Cross.from.withAlphaComponent(0.4).cgColor,
      colorTo: Colors.Gradients.Cross.from.withAlphaComponent(0).cgColor
    )

    if withShadow {
      layer.addSublayer(shadowLayer)
    }
    layer.addSublayer(gradientLayer)

    setConstraintsConstant(width: markerWidth)
  }

}

extension Cross {

  private func getLineLayer(from: CGPoint, to: CGPoint, lineWidth: CGFloat) -> CALayer {
    let linePath = UIBezierPath()
    linePath.move(to: from)
    linePath.addLine(to: to)

    let lineLayer = CAShapeLayer()
    lineLayer.path = linePath.cgPath
    lineLayer.fillColor = UIColor.clear.cgColor

    lineLayer.strokeColor = UIColor.blue.cgColor
    lineLayer.lineWidth = lineWidth
    lineLayer.lineCap = .square

    return lineLayer
  }

}
