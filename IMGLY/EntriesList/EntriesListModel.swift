import Foundation
import Dependencies

@MainActor
final class EntriesListModel: ObservableObject {
  @Published var destination: Destination?
  @Published var entries: [Entry] = []

  var draggedItem: Entry?

  @Dependency(\.apiClient) var apiClient

  enum Destination {
    case details(EntryDetailsModel)
  }

  func task() async {
    do {
      self.entries = try await apiClient.getEntries()
    } catch let error {
      print("\(error)")
    }
  }

  func delete(entry: Entry) {
    guard let parent = entry.parent else {
      entries.removeAll(where: { $0 === entry })
      objectWillChange.send()
      return
    }
    parent.children?.removeAll(where: { $0 === entry })
    objectWillChange.send()
  }

  func entryTapped(id: String) {
    self.destination = .details(
      withDependencies(from: self) {
        EntryDetailsModel(id: id)
      }
    )
  }

  func move(currentEntry: Entry) -> Bool {
    guard let draggedItem, draggedItem.id != currentEntry.id else {
      return true
    }

    guard draggedItem.parent === currentEntry.parent else {
      return false
    }

    if let parent = draggedItem.parent {
      parent.children?.swap(draggedItem, currentEntry)
    } else {
      self.entries.swap(draggedItem, currentEntry)
    }
    objectWillChange.send()

    self.draggedItem = nil
    return true
  }
}

extension Array where Element == Entry {
  mutating func swap(_ firstItem: Entry, _ secondItem: Entry) {
    if let firstIndex = self.firstIndex(where: { $0 === firstItem }),
        let secondIndex = self.firstIndex(where: { $0 === secondItem }) {
      swapAt(firstIndex, secondIndex)
    }
  }
}
