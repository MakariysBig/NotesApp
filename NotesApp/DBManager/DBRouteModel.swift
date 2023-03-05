import RealmSwift
import Foundation

@objcMembers
final class NoteModel: Object {
    dynamic var id = UUID().uuidString
    dynamic var title = String()
    dynamic var subtitle = String()
    
    override static func primaryKey() -> String? {
      return "id"
    }
    
    convenience init(title: String, subtitle: String) {
        self.init()
        self.title    = title
        self.subtitle = subtitle
    }
    
    override init() {
        super.init()
    }
}
