import SwiftUI

// MARK: - DefaultTag

enum DefaultTag: String {
   case all = "All Notes"
   case fav = "Favorite Notes"
}

// MARK: - Home

struct Home: View {

   // MARK: Internal

   var body: some View {
      NavigationSplitView {

         List(selection: $selectedTag) {

            Text("All")
               .tag(DefaultTag.all.rawValue)
               .foregroundStyle(selectedTag == DefaultTag.all.rawValue ? .primary : .secondary)

            Text("Favorites")
               .tag(DefaultTag.fav.rawValue)
               .foregroundStyle(selectedTag == DefaultTag.fav.rawValue ? .primary : .secondary)

            // User created categories
            Section {} header: {
               HStack(spacing: 6) {
                  Text("Categories")

                  Button("", systemImage: "plus") {}
                     .help("Create a new category")
                     .buttonStyle(.plain)
                     .tint(.gray)
                     .offset(y: -2)
               }
            }

         }

      } detail: {}
         .navigationTitle(selectedTag ?? "$(PRODUCT_NAME)")
   }

   // MARK: Private

   /// This is used to filter the selected note category
   @State private var selectedTag: String? = "All Notes"

}

#Preview {
   ContentView()
}
