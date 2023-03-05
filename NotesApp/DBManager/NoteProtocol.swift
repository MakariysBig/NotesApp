import Foundation

protocol NoteRepositoryProtocol {
    func save(model: NoteModel)
    func getAllNoteModels() -> [NoteModel]
    func deleteFromDB(id: String)
    func updateNoteModel(id: String, title: String, subtitle: String)
}

final class NoteRepository: NoteRepositoryProtocol {
    private let dbManager: DBManager
    
    init(dbManager: DBManager = DBManagerImpl()) {
        self.dbManager = dbManager
    }
    
    func save(model: NoteModel) {
        dbManager.saveNoteModel(data: model)
    }
    
    func getAllNoteModels() -> [NoteModel] {
        dbManager.getAllNoteModels()
    }
    
    func deleteFromDB(id: String) {
        dbManager.removeNoteModel(id: id)
    }
    
    func updateNoteModel(id: String, title: String, subtitle: String) {
        dbManager.updateNoteModel(id: id, title: title, subtitle: subtitle)
    }
}
