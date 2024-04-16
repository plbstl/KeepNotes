import SwiftData
import SwiftUI

// MARK: - Home

struct Home: View {

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
               ForEach(categories) { category in
                  Text(category.title)
                     .tag(category.title)
                     .foregroundStyle(selectedTag == category.title ? .primary : .secondary)
               }
            } header: {
               HStack(spacing: 6) {
                  Text("Categories")

                  Button("", systemImage: "plus") {
                     shouldCreateNewCategory = true
                  }
                  .help("Create a new category")
                  .buttonStyle(.plain)
                  .tint(.gray)
                  .offset(y: -2)
               }
            }
         }

      } detail: {}
         .navigationTitle(selectedTag ?? Constants.AppInfo.name)
         .alert("Create a new category", isPresented: $shouldCreateNewCategory) {
            TextField("Category name", text: $newCategoryTitle)

            Button("Create") {
               // Do not create a category with an empty title
               guard !newCategoryTitle.isEmpty else {
                  return
               }

               // Create new category and add to modelContext
               let category = NoteCategory(title: newCategoryTitle)
               modelContext.insert(category)
               newCategoryTitle = ""
            }

            Button("Cancel", role: .cancel) {
               // Do nothing. For convenience, do not reset newCategoryTitle
            }

         }
   }

   // MARK: Private

   @Environment(\.modelContext) private var modelContext
   @Query(animation: .bouncy) private var categories: [NoteCategory]
   /// Whether to show an alert for creating a new category in the NavigationSplitView
   @State private var shouldCreateNewCategory = false
   /// this is used when creating a new category
   @State private var newCategoryTitle = ""
   /// This is used to filter the selected note category
   @State private var selectedTag: String? = "All Notes"

}

#Preview {
   ContentView()
}
