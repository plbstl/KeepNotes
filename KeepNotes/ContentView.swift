import SwiftData
import SwiftUI

struct ContentView: View {

   // MARK: Internal

   var body: some View {
      NavigationSplitView {
         List {
            NavigationLink {
               Text("Detail View for all notes")
            } label: {
               Text("All notes").help("View all notes")
            }
         }
         .navigationSplitViewColumnWidth(min: 140, ideal: 200, max: 400)
      } detail: {
         Text("Default detail view. Select a category")
      }
   }

   // MARK: Private

   @Environment(\.modelContext) private var modelContext
}

#Preview {
   ContentView()
      .modelContainer(for: Note.self, inMemory: true)
}
