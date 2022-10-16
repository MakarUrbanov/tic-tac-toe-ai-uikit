//
// Created by makar on 10/16/22.
//

import UIKit

final class Cross: BaseMark {

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

  func draw(width: CGFloat, withShadow: Bool = false) {
    let linesLayer = CAShapeLayer()
    let reductionValue = getReductionValue(frameWidth: width)
    let lineWidth = getLineWidth(frameWidth: width)

    // Draw lines
    let firstLineLayer = getLineLayer(
      from: CGPoint(x: width - reductionValue, y: reductionValue),
      to: CGPoint(x: reductionValue, y: width - reductionValue),
      lineWidth: lineWidth
    )
    let secondLineLayer = getLineLayer(
      from: CGPoint(x: reductionValue, y: reductionValue),
      to: CGPoint(x: width - reductionValue, y: width - reductionValue),
      lineWidth: lineWidth
    )

    linesLayer.addSublayer(firstLineLayer)
    linesLayer.addSublayer(secondLineLayer)

    let gradientLayer = getGradient(
      width: width,
      colorFrom: Colors.Gradients.Cross.from.cgColor,
      colorTo: Colors.Gradients.Cross.to.cgColor,
      on: linesLayer
    )

    let shadowLayer = getShadow(
      width: width,
      colorFrom: Colors.Gradients.Cross.from.withAlphaComponent(0.6).cgColor,
      colorTo: Colors.Gradients.Cross.from.withAlphaComponent(0).cgColor
    )

    if withShadow {
      layer.addSublayer(shadowLayer)
    }
    layer.addSublayer(gradientLayer)

    setConstraintsConstant(width: width)
  }

}
