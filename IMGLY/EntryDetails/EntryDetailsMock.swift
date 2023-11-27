import Foundation

extension EntryDetails {
  static var mock: Self {
    EntryDetails(
      id: "mock_id",
      createdAt: "mock_createdAt",
      createdBy: "mock_createdBy",
      lastModifiedAt: "mock_lastModifiedAt",
      lastModifiedBy: "mock_lastModifiedBy",
      description: "mock_description"
    )
  }
}
