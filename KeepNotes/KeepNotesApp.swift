import SwiftData
import SwiftUI

@main struct KeepNotesApp: App {

   var sharedModelContainer = {
      let schema = Schema([Note.self, NoteCategory.self])
      let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

      do {
         return try ModelContainer(for: schema, configurations: [modelConfiguration])
      } catch {
         fatalError("Could not create ModelContainer: \(error)")
      }
   }()

   var body: some Scene {
      WindowGroup {
         ContentView()
            .frame(minWidth: 400, minHeight: 300)
      }
      .windowResizability(.contentSize)
      .modelContainer(sharedModelContainer)
   }

}
