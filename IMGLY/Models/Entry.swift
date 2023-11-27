import Foundation

final class Entry {
  let label: String
  let remoteId: String?
  var children: [Entry]?

  weak var parent: Entry?

  var level: Int {
    var currentLevel = 0
    var currentParent = parent
    while currentParent != nil {
      currentLevel += 1
      currentParent = currentParent?.parent
    }
    return currentLevel
  }

  init(label: String, remoteId: String? = nil, children: [Entry]? = nil) {
    self.label = label
    self.remoteId = remoteId
    self.children = children

    children?.forEach { $0.parent = self }
  }
}

extension Entry: Identifiable {
  var id: String {
    label
  }
}

extension Entry: Decodable {
  enum CodingKeys: String, CodingKey {
    case id, label, children
  }

  convenience init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let remoteId = try container.decodeIfPresent(String.self, forKey: .id)
    let label = try container.decode(String.self, forKey: .label)
    let children = try container.decodeIfPresent([Entry].self, forKey: .children)
    self.init(label: label, remoteId: remoteId, children: children)
  }
}
