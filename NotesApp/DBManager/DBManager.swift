import Foundation
import RealmSwift

protocol DBManager {
    func saveNoteModel(data: NoteModel)
    func getAllNoteModels() -> [NoteModel]
    func updateNoteModel(id: String, title: String, subtitle: String)
    func removeNoteModel(id: String)
}

final class DBManagerImpl: DBManager {
    let realm = try! Realm()
    
    //MARK: - Note model
    
    func saveNoteModel(data: NoteModel) {
        try! realm.write {
            realm.add(data, update: .modified)
        }
    }
    
    func getAllNoteModels() -> [NoteModel] {
        let models = realm.objects(NoteModel.self)
        return Array(models)
    }
    
    func removeNoteModel(id: String) {
        let model = Array(realm.objects(NoteModel.self).filter("id == %@", id))
        guard let model = model.first else { return }
        dump(model)
        try! realm.write {
            realm.delete(model)
        }
    }
    
    func updateNoteModel(id: String, title: String, subtitle: String) {
        let model = Array(realm.objects(NoteModel.self).filter("id == %@", id))
        guard let model = model.first else { return }
        dump(model)
        try! realm.write {
            model.setValue(title, forKey: "title")
            model.setValue(subtitle, forKey: "subtitle")
        }
    }
}
