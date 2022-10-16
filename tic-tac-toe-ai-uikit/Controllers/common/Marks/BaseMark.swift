//
// Created by makar on 10/16/22.
//

import UIKit

protocol BaseMarkProtocol: BaseView {
  func getShadow(width: CGFloat, colorFrom: CGColor, colorTo: CGColor) -> CALayer
  func getGradient(width: CGFloat, colorFrom: CGColor, colorTo: CGColor, on mask: CALayer) -> CALayer
  func getLineWidth(frameWidth: CGFloat) -> CGFloat
  func getReductionValue(frameWidth: CGFloat) -> CGFloat
  func setConstraintsConstant(width: CGFloat)
}

class BaseMark: BaseView, BaseMarkProtocol {
  func getShadow(width: CGFloat, colorFrom: CGColor, colorTo: CGColor) -> CALayer {
    let shadowLayer = CAGradientLayer()
    shadowLayer.type = .radial
    shadowLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
    shadowLayer.endPoint = CGPoint(x: 1.0, y: 1)
    shadowLayer.colors = [colorFrom, colorTo]
    let shadowHeight = width / 3
    let shadowWidth = width * 0.9
    let shadowFrame = CGRect(
      x: (width - shadowWidth) / 2,
      y: width - shadowHeight / 1.2,
      width: shadowWidth,
      height: shadowHeight
    )
    shadowLayer.frame = shadowFrame

    return shadowLayer
  }

  func getGradient(width: CGFloat, colorFrom: CGColor, colorTo: CGColor, on mask: CALayer) -> CALayer {
    let gradientLayer = CAGradientLayer()
    gradientLayer.startPoint = CGPoint(x: 0, y: 1)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0)

    gradientLayer.colors = [colorFrom, colorTo]
    gradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: width)
    gradientLayer.mask = mask

    return gradientLayer
  }

  func getLineWidth(frameWidth: CGFloat) -> CGFloat {
    frameWidth * 0.3
  }

  func getReductionValue(frameWidth: CGFloat) -> CGFloat {
    frameWidth * 0.7
  }

  func setConstraintsConstant(width: CGFloat) {
    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: width),
      heightAnchor.constraint(equalToConstant: width)
    ])
  }

}
