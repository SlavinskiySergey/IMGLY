import Foundation
import Dependencies
import Get

struct ApiClient {
  var getEntries: @Sendable () async throws -> [Entry]
  var getEntryDetails: @Sendable (String) async throws -> EntryDetails
}

extension ApiClient: DependencyKey {
  static let liveValue: Self = {
    let networkClient = APIClient(baseURL: URL(string: "https://ubique.img.ly/frontend-tha"))

    return Self(
      getEntries: {
        let request = Request<[Entry]>(
          path: "/data.json"
        )
        return try await networkClient.send(request).value
      },
      getEntryDetails: { id in
        let request = Request<EntryDetails>(
          path: "/entries/\(id).json"
        )
        return try await networkClient.send(request).value
      }
    )
  }()
}

extension ApiClient {
  static let testValue: ApiClient = ApiClient(
    getEntries: unimplemented("getEntries"),
    getEntryDetails: unimplemented("getEntryDetails")
  )

  static var previewValue: ApiClient {
    return Self(
      getEntries: {
        try await Task.sleep(nanoseconds: 1_000_000_000) 
        return .mocks
      },
      getEntryDetails: { _ in
        try await Task.sleep(nanoseconds: 2 * 1_000_000_000) 
        return .mock
      }
    )
  }
}

extension DependencyValues {
  var apiClient: ApiClient {
    get { self[ApiClient.self] }
    set { self[ApiClient.self] = newValue }
  }
}
