import SwiftData
import SwiftUI

@main struct KeepNotesApp: App {

   var sharedModelContainer: ModelContainer = {
      let schema = Schema([Note.self, NoteCategory.self])
      let modelConfiguration = ModelConfiguration(schema: schema)

      do {
         return try ModelContainer(for: schema, configurations: [modelConfiguration])
      } catch {
         fatalError("Could not create ModelContainer: \(error)")
      }
   }()

   var body: some Scene {
      WindowGroup {
         ContentView()
      }
      .modelContainer(sharedModelContainer)
   }

}
