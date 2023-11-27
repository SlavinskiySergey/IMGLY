import SwiftUI

struct Delete: ViewModifier {
  let action: () -> Void

  @State var offset: CGSize = .zero
  @State var initialOffset: CGSize = .zero
  @State var contentWidth: CGFloat = 0.0
  @State var willDeleteIfReleased = false

  //MARK: Constants
  private let deletionDistance = CGFloat(120)
  private let halfDeletionDistance = CGFloat(56)
  private let tappableDeletionWidth = CGFloat(70)
  private let trashVisibleDistance = CGFloat(25)

  func body(content: Content) -> some View {
    content
      .background(
        GeometryReader { geometry in
          ZStack {
            Rectangle()
              .foregroundColor(.red)

            Image(systemName: "trash")
              .fixedSize()
              .foregroundColor(.white)
              .layoutPriority(-1)
              .opacity(-offset.width < trashVisibleDistance ? 0 : 1)
          }
          .frame(width: -offset.width)
          .offset(x: geometry.size.width)
          .onAppear {
            contentWidth = geometry.size.width
          }
          .gesture(
            TapGesture()
              .onEnded {
                delete()
              }
          )
        }
      )
      .offset(x: offset.width)
      .contentShape(Rectangle())
      .gesture(
        DragGesture()
          .onChanged { gesture in
            if gesture.translation.width + initialOffset.width <= 0 {
              self.offset.width = gesture.translation.width + initialOffset.width
            }
            if self.offset.width < -deletionDistance && !willDeleteIfReleased {
              hapticFeedback()
              willDeleteIfReleased.toggle()
            } else if offset.width > -deletionDistance && willDeleteIfReleased {
              hapticFeedback()
              willDeleteIfReleased.toggle()
            }
          }
          .onEnded { _ in
            if offset.width < -deletionDistance {
              delete()
            } else if offset.width < -halfDeletionDistance {
              offset.width = -tappableDeletionWidth
              initialOffset.width = -tappableDeletionWidth
            } else {
              offset = .zero
              initialOffset = .zero
            }
          }
      )
  }

  private func delete() {
    offset.width = -contentWidth
    action()
  }

  private func hapticFeedback() {
    let generator = UIImpactFeedbackGenerator(style: .medium)
    generator.impactOccurred()
  }
}

extension View {
  func onDelete(perform action: @escaping () -> Void) -> some View {
    self.modifier(Delete(action: action))
  }
}
