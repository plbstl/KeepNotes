import SwiftData
import SwiftUI

// MARK: - Home

struct HomeView: View {

   // MARK: Internal

   @State var shouldDeleteCategory = false
   @State var requestedCategory: NoteCategory? = nil
   @State var searchTerm = ""

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
                     text: Binding(get: { category.title }, set: { category.title = $0 }),
                     prompt: Text("Required")
                  )
                  .onSubmit {
                     // TODO: user can input an already used category title
                     category.tag = category.title
                  }
                  .tag(category.tag)
                  .foregroundStyle(selectedTag == category.title ? .primary : .secondary)
                  .contextMenu {
                     Button("Delete") {
                        requestedCategory = category
                        shouldDeleteCategory = true
                     }
                  }
               }
            } header: {
               HStack(spacing: 6) {
                  Text("Categories")

                  Button("", systemImage: "plus") {
                     let noteCategory = generateUntitledCategory()
                     modelContext.insert(noteCategory)
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
         .alert("\(requestedCategory?.title ?? "")\n\nDelete category and all notes in it\n", isPresented: $shouldDeleteCategory) {
            Button("Cancel", role: .cancel) {
               requestedCategory = nil
               shouldDeleteCategory = false
            }
            Button("Delete", role: .destructive) {
               if let requestedCategory {
                  modelContext.delete(requestedCategory)
                  self.requestedCategory = nil
                  shouldDeleteCategory = false
               }
            }
         }
         .toolbar {
            ToolbarItem {
               HStack(spacing: 10) {

                  TextField("Search", text: $searchTerm)
                     .frame(width: 120, alignment: .topLeading)

                  Button("", systemImage: "plus") {}
                     .help("Add new note")

               }
            }
         }

   }

   // MARK: Private

   @Environment(\.modelContext) private var modelContext
   @Query(sort: \NoteCategory.creationDate, order: .reverse, animation: .snappy) private var categories: [NoteCategory]
   @State private var selectedTag = "All Notes"

   private func generateUntitledCategory() -> NoteCategory {
      let baseName = "Untitled"
      var i = 0
      while true {
         let categoryName = i > 0 ? "\(baseName) \(i)" : baseName
         if !categories.contains(where: { $0.title == categoryName }) {
            return NoteCategory(title: categoryName)
         }
         i += 1
      }
   }

}

#Preview {
   ContentView()
}
