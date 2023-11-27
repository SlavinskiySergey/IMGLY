import Foundation

extension Array where Element == Entry {
  static var mocks: Self {
    [
      Entry(
        label: "img.ly",
        children: [
          Entry(
            label: "Workspace A",
            children: [
              Entry(label: "Entry 1", remoteId: "imgly.A.1"),
              Entry(label: "Entry 2", remoteId: "imgly.A.2"),
              Entry(label: "Entry 3", remoteId: "imgly.A.3")
            ]
          ),
          Entry(
            label: "Workspace B",
            children: [
              Entry(label: "Entry 1", remoteId: "imgly.B.1"),
              Entry(label: "Entry 2", remoteId: "imgly.B.2"),
              Entry(label: "Entry 3", remoteId: "imgly.B.3")
            ]
          )
        ]
      )
    ]
  }
}
