import Foundation
import SwiftData

@Model final class Note {

   // MARK: Lifecycle

   init(content: String, category: NoteCategory? = nil) {
      self.content = content
      self.category = category
      isFavorite = false
      creationDate = Date()
   }

   // MARK: Internal

   let creationDate: Date
   var content: String
   var isFavorite: Bool
   var category: NoteCategory?

}
