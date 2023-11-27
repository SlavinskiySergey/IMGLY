import Foundation

struct EntryDetails {
  let id: String
  let createdAt: String
  let createdBy: String
  let lastModifiedAt: String
  let lastModifiedBy: String
  let description: String
}

extension EntryDetails: Decodable {}
