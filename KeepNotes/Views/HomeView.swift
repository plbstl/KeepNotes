import SwiftData
import SwiftUI

// MARK: - Home

struct HomeView: View {

   // MARK: Internal

   var body: some View {

      NavigationSplitView {
         List(selection: $selectedTag) {
            Text("All")
               .tag(Constants.Tag.all)
               .foregroundStyle(selectedTag == Constants.Tag.all ? .primary : .secondary)

            Text("Favorites")
               .tag(Constants.Tag.favorite)
               .foregroundStyle(selectedTag == Constants.Tag.favorite ? .primary : .secondary)

            // User created categories
            Section {
               ForEach(categories) { (category: NoteCategory) in
                  TextField(
                     "New Category",
                     text: Binding(get: { category.title }, set: { category.title = $0 })
                  )
                  .onSubmit {
                     category.tag = category.title
                  }
                  .tag(category.tag)
                  .foregroundStyle(selectedTag == category.title ? .primary : .secondary)
               }
            } header: {
               HStack(spacing: 6) {
                  Text("Categories")

                  Button("", systemImage: "plus") {
                     modelContext.insert(NoteCategory())
                  }
                  .help("Create a new category")
                  .buttonStyle(.plain)
                  .tint(.gray)
                  .offset(y: -2)
               }

            }
         }

      } detail: {}
         .navigationTitle(selectedTag)

   }

   // MARK: Private

   @Environment(\.modelContext) private var modelContext
   @Query(sort: \NoteCategory.creationDate, order: .reverse, animation: .bouncy) private var categories: [NoteCategory]
   @State private var selectedTag = "All Notes"

}

#Preview {
   ContentView()
}