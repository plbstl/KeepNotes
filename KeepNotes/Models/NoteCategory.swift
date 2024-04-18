import Foundation
import SwiftData

// MARK: - Category

@Model final class NoteCategory {

   // MARK: Lifecycle

   init(title: String) {
      self.title = title
      tag = title
   }

   // MARK: Internal

   var title: String
   var tag: String
   let creationDate = Date.now
   @Relationship(deleteRule: .cascade, inverse: \Note.category) var notes = [Note]()

}
