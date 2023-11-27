import SwiftUI

struct ListRowModifier: ViewModifier {

  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.vertical, 8)
  }
}

extension View {
  func listRow() -> some View {
    self.modifier(ListRowModifier())
  }
}
