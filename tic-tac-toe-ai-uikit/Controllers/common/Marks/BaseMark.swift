//
// Created by makar on 10/16/22.
//

import UIKit

protocol BaseMarkProtocol: UIView {
  func getShadow(colorFrom: CGColor, colorTo: CGColor) -> CALayer
  func getGradient(colorFrom: CGColor, colorTo: CGColor, on mask: CALayer) -> CALayer
  func setConstraintsConstant(width: CGFloat)
}

protocol DrawableMarkProtocol: BaseMark {
  func draw()
}

class BaseMark: UIView, BaseMarkProtocol {

  private(set) var markerWidth: CGFloat
  private(set) var withShadow = true
  var lineWidth: CGFloat {
    markerWidth * 0.3
  }
  var reductionValue: CGFloat {
    markerWidth * 0.7
  }

  init(width: CGFloat, withShadow: Bool = true) {
    markerWidth = width
    self.withShadow = withShadow

    super.init(frame: .zero)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension BaseMark {

  func getShadow(colorFrom: CGColor, colorTo: CGColor) -> CALayer {
    let shadowLayer = CAGradientLayer()
    shadowLayer.type = .radial
    shadowLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
    shadowLayer.endPoint = CGPoint(x: 1.0, y: 1)
    shadowLayer.colors = [colorFrom, colorTo]
    let shadowHeight = markerWidth / 3
    let shadowWidth = markerWidth * 0.9
    let shadowFrame = CGRect(
      x: (markerWidth - shadowWidth) / 2,
      y: markerWidth - shadowHeight / 1.2,
      width: shadowWidth,
      height: shadowHeight
    )
    shadowLayer.frame = shadowFrame

    return shadowLayer
  }

  func getGradient(colorFrom: CGColor, colorTo: CGColor, on mask: CALayer) -> CALayer {
    let gradientLayer = CAGradientLayer()
    gradientLayer.startPoint = CGPoint(x: 0, y: 1)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0)

    gradientLayer.colors = [colorFrom, colorTo]
    gradientLayer.frame = CGRect(x: 0, y: 0, width: markerWidth, height: markerWidth)
    gradientLayer.mask = mask

    return gradientLayer
  }

  func setConstraintsConstant(width: CGFloat) {
    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: width),
      heightAnchor.constraint(equalToConstant: width)
    ])
  }

}
