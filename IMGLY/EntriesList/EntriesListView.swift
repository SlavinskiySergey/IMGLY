import SwiftUI
import SwiftUINavigation
import Dependencies

struct EntriesListView: View {
  @ObservedObject var model: EntriesListModel

  var body: some View {
    NavigationView {
      ScrollView(showsIndicators: false) {
        LazyVStack {
          ForEach(model.entries) { entry in
            OutlineGroup(entry, children: \.children) { subEntry in
              VStack(alignment: .leading, spacing: 4) {
                Text(subEntry.label)

                if let id = subEntry.remoteId {
                  Button {
                    self.model.entryTapped(id: id)
                  } label: {
                    Text(id)
                      .foregroundStyle(ColorPalette.title.color)
                  }
                }
              }
              .padding(.leading, CGFloat(3 * subEntry.level))
              .listRow()
              .onDelete {
                model.delete(entry: subEntry)
              }
              .onDrag {
                model.draggedItem = subEntry
                return NSItemProvider(object: subEntry.label as NSString)
              }
              .onDrop(
                of: [.text],
                delegate: DropViewDelegate(model: model, subEntry: subEntry)
              )
            }
          }
        }
      }
      .padding(.horizontal, 16)
      .background(
        NavigationLink(
          unwrapping: self.$model.destination,
          case: /EntriesListModel.Destination.details,
          onNavigate: { _ in },
          destination: { $model in
            EntryDetailsView(model: model)
          },
          label: EmptyView.init
        )
      )
    }
    .task { await self.model.task() }
  }
}

struct DropViewDelegate: DropDelegate {
  var model: EntriesListModel
  var subEntry: Entry

  func performDrop(info: DropInfo) -> Bool {
    model.move(currentEntry: subEntry)
  }
}


#Preview {
  EntriesListView(
    model: withDependencies {
      $0.apiClient = .previewValue
    } operation: {
      EntriesListModel()
    }
  )
}
