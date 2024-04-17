import Foundation
import SwiftData

// MARK: - Category

@Model final class NoteCategory {

   // MARK: Lifecycle

   init() {}

   // MARK: Internal

   let creationDate = Date.now
   var tag = UUID().uuidString
   var title = "Untitled"
   @Relationship(deleteRule: .cascade, inverse: \Note.category) var notes = [Note]()

}
