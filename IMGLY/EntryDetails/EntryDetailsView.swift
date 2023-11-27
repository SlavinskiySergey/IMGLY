import SwiftUI
import Dependencies

struct EntryDetailsView: View {
  @ObservedObject var model: EntryDetailsModel

  var body: some View {
    Group {
      switch model.layoutState {
      case .error(let error):
        Text(error.localizedDescription)

      case .loading:
        ProgressView()

      case .data(let model):
        VStack(alignment: .leading, spacing: 8) {
          Text("ID: \(model.id)")
          Text("CreatedAt: \(model.createdAt)")
          Text("CreatedBy: \(model.createdBy)")
          Text("LastModifiedAt: \(model.lastModifiedAt)")
          Text("LastModifiedBy: \(model.lastModifiedBy)")
          Text("Description: \(model.description)")
        }
        .padding(.horizontal, 16)
      }
    }
    .task { await self.model.task() }
  }
}

#Preview {
  EntryDetailsView(
    model: withDependencies {
      $0.apiClient = .previewValue
    } operation: {
      EntryDetailsModel(id: "mock")
    }
  )
}
