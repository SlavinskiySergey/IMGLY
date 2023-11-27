import UIKit
import SwiftUI

struct ColorPalette {
  static let title = mode(0x101418, 0xffffff)

  static func mode(_ light: Int, lightAlpha: CGFloat = 1.0, _ dark: Int, darkAlpha: CGFloat = 1.0) -> UIColor {
    UIColor { traitCollection in
      traitCollection.userInterfaceStyle == .dark
      ? UIColor(rgb: dark).withAlphaComponent(darkAlpha)
      : UIColor(rgb: light).withAlphaComponent(lightAlpha)
    }
  }
}

extension UIColor {
  convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
    self.init(
      red: r / 255,
      green: g / 255,
      blue: b / 255,
      alpha: 1
    )
  }

  convenience init(red: Int, green: Int, blue: Int) {
    self.init(
      r: CGFloat(red),
      g: CGFloat(green),
      b: CGFloat(blue)
    )
  }

  convenience init(rgb: Int) {
    self.init(
      red: (rgb >> 16) & 0xff,
      green: (rgb >> 8) & 0xff,
      blue: rgb & 0xff
    )
  }

  var color: Color {
    return Color(uiColor: self)
  }
}
