import Foundation
import SwiftData

@Model final class Note {

   // MARK: Lifecycle

   init(content: String, category: NoteCategory? = nil) {
      self.content = content
      self.category = category
   }

   // MARK: Internal

   let creationDate = Date.now
   var isFavorite = false
   var content: String
   var category: NoteCategory?

}
