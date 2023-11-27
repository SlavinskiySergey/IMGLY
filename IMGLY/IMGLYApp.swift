import SwiftUI

@main
struct IMGLYApp: App {
  var body: some Scene {
    WindowGroup {
      EntriesListView(
        model: EntriesListModel()
      )
    }
  }
}
