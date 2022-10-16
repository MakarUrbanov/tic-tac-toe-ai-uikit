//
// Created by makar on 10/16/22.
//

import UIKit

enum Fonts {

  static func helveticaRegular(size: CGFloat) -> UIFont {
    UIFont(name: "Helvetica", size: size) ?? UIFont()
  }

  static func helveticaBold(size: CGFloat) -> UIFont {
    UIFont(name: "Helvetica-Bold", size: size) ?? UIFont()
  }

}
