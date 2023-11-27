import Foundation
import Dependencies

@MainActor
final class EntryDetailsModel: ObservableObject {
  let id: String
  @Published var layoutState: LayoutState<EntryDetails> = .loading

  @Dependency(\.apiClient) var apiClient

  init(id: String) {
    self.id = id
  }

  func task() async {
    do {
      let model = try await apiClient.getEntryDetails(id)
      self.layoutState = .data(model)
    } catch let error {
      self.layoutState = .error(error)
    }
  }
}
