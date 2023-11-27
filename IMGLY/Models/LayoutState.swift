import Foundation

enum LayoutState<Model> {
  case error(Error)
  case loading
  case data(Model)
}
