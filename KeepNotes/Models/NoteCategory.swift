import Foundation
import SwiftData

// MARK: - Category

@Model final class NoteCategory {

   // MARK: Lifecycle

   init(title: String) {
      self.title = title
      notes = []
   }

   // MARK: Internal

   var title: String
   @Relationship(deleteRule: .cascade, inverse: \Note.category) var notes: [Note]

}
