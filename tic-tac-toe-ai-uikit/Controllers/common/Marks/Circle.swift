//
// Created by makar on 10/16/22.
//

import UIKit

final class Circle: BaseMark, DrawableMarkProtocol {

  func draw() {
    let radius = markerWidth / 2 - (reductionValue * 1.1)
    let circleCenter = CGPoint(x: markerWidth / 2, y: markerWidth / 2)
    let circlePath = UIBezierPath(
      arcCenter: circleCenter,
      radius: radius,
      startAngle: 0,
      endAngle: CGFloat.pi * 2,
      clockwise: true
    )

    let circleLayer = CAShapeLayer()
    circleLayer.path = circlePath.cgPath
    circleLayer.strokeColor = UIColor.white.cgColor
    circleLayer.fillColor = UIColor.clear.cgColor
    circleLayer.lineWidth = lineWidth
    circleLayer.lineCap = .round

    let gradientLayer = getGradient(
      colorFrom: Colors.Gradients.Circle.from.cgColor,
      colorTo: Colors.Gradients.Circle.to.cgColor,
      on: circleLayer
    )

    let shadowLayer = getShadow(
      colorFrom: Colors.Gradients.Circle.from.withAlphaComponent(0.4).cgColor,
      colorTo: Colors.Gradients.Circle.from.withAlphaComponent(0).cgColor
    )

    if withShadow {
      layer.addSublayer(shadowLayer)
    }
    layer.addSublayer(gradientLayer)

    setConstraintsConstant(width: markerWidth)
  }

}
