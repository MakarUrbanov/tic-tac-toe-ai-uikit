//
// Created by makar on 10/16/22.
//

import UIKit

class XMark: BaseView {
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

  func draw(width: CGFloat) {
    let linesLayer = CAShapeLayer()
    let reductionRatio = width * 0.7
    let lineWidth = width * 0.3

    // Draw lines
    let firstLineLayer = getLineLayer(
      from: CGPoint(x: width - reductionRatio, y: reductionRatio),
      to: CGPoint(x: reductionRatio, y: width - reductionRatio),
      lineWidth: lineWidth
    )
    let secondLineLayer = getLineLayer(
      from: CGPoint(x: reductionRatio, y: reductionRatio),
      to: CGPoint(x: width - reductionRatio, y: width - reductionRatio),
      lineWidth: lineWidth
    )

    linesLayer.addSublayer(firstLineLayer)
    linesLayer.addSublayer(secondLineLayer)

    // Gradient Layer
    let gradientLayer = CAGradientLayer()
    gradientLayer.startPoint = CGPoint(x: 0, y: 1)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0)

    gradientLayer.colors = [Colors.Gradients.XMark.from.cgColor, Colors.Gradients.XMark.to.cgColor]
    gradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: width)
    gradientLayer.mask = linesLayer

    // Shadow layer
    let shadowLayer = CAGradientLayer()
    shadowLayer.type = .radial
    shadowLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
    shadowLayer.endPoint = CGPoint(x: 1.0, y: 1)
    shadowLayer.colors = [
      Colors.Gradients.XMark.from.withAlphaComponent(0.6).cgColor,
      Colors.Gradients.XMark.from.withAlphaComponent(0).cgColor
    ]
    let shadowHeight = width / 3
    let shadowWidth = width * 0.9
    let shadowFrame = CGRect(
      x: (width - shadowWidth) / 2,
      y: width - shadowHeight / 1.2,
      width: shadowWidth,
      height: shadowHeight
    )
    shadowLayer.frame = shadowFrame

    layer.addSublayer(shadowLayer)
    layer.addSublayer(gradientLayer)
  }

}

extension XMark {

  override func setViews() {
    super.setViews()
  }

  override func setConstraints() {
    super.setConstraints()
  }

  override func setAppearanceConfiguration() {
    super.setAppearanceConfiguration()
  }

}
