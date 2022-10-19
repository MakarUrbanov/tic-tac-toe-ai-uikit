//
// Created by makar on 10/16/22.
//

import UIKit

final class Nought: BaseMark, DrawableMarkProtocol {

  func draw() {
    let radius = markerWidth / 2 - (reductionValue * 1.1)
    let noughtCenter = CGPoint(x: markerWidth / 2, y: markerWidth / 2)
    let noughtPath = UIBezierPath(
      arcCenter: noughtCenter,
      radius: radius,
      startAngle: 0,
      endAngle: CGFloat.pi * 2,
      clockwise: true
    )

    let noughtLayer = CAShapeLayer()
    noughtLayer.path = noughtPath.cgPath
    noughtLayer.strokeColor = UIColor.white.cgColor
    noughtLayer.fillColor = UIColor.clear.cgColor
    noughtLayer.lineWidth = lineWidth
    noughtLayer.lineCap = .round

    let gradientLayer = getGradient(
      colorFrom: Colors.Gradients.Nought.from.cgColor,
      colorTo: Colors.Gradients.Nought.to.cgColor,
      on: noughtLayer
    )

    let shadowLayer = getShadow(
      colorFrom: Colors.Gradients.Nought.from.withAlphaComponent(0.4).cgColor,
      colorTo: Colors.Gradients.Nought.from.withAlphaComponent(0).cgColor
    )

    if withShadow {
      layer.addSublayer(shadowLayer)
    }
    layer.addSublayer(gradientLayer)

    setConstraintsConstant(width: markerWidth)
  }

}
