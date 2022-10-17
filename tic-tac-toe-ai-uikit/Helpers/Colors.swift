//
// Created by makar on 10/16/22.
//

import UIKit

enum Colors {

  static let background = UIColor(hex: "#F8F8F8")
  static let black = UIColor(hex: "#000000")
  static let activeButton = UIColor(hex: "#2f70f8")

  enum Gradients {
    enum Cross {
      static let from = UIColor(hex: "#2f70f8")
      static let to = UIColor(hex: "#8dffef")
    }

    enum Circle {
      static let from = UIColor(hex: "#f97033")
      static let to = UIColor(hex: "#f7df77")
    }
  }

  enum Text {
    static let primaryBlack = UIColor(hex: "#404040")
  }

}
