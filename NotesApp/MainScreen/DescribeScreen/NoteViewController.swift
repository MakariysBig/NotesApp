import UIKit

final class NoteViewController: UIViewController {
    
    //MARK: - Properties
    
    private let repository = NoteRepository()
    private let note: NoteModel
    private let type: TypeEnum
  
    private var rootView: NoteView {
        view as! NoteView
    }
    
    //MARK: - Initialise
    
    init(note: NoteModel, type: TypeEnum) {
        self.note = note
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func loadView() {
        view = NoteView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if type == .create {
            rootView.textView.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if type == .create {
            let text = rootView.textView.text
            
            if text != "" {
                let model = separateText()
                repository.save(model: model)
            }
        } else {
            let model = separateText()
            checkModelIsEmpty(model: model)
        }
    }
    
    //MARK: - Private methods
    
    private func checkModelIsEmpty(model: NoteModel) {
        if model.title == "" && model.subtitle == "" {
            repository.deleteFromDB(id: note.id)
        } else {
            repository.updateNoteModel(id: note.id, title: model.title, subtitle: model.subtitle)
        }
    }
    
    private func setup() {
        navigationController?.navigationBar.prefersLargeTitles = false
        rootView.updateView(model: note, type: type)
    }
    
    private func separateText() -> NoteModel {
        let text = rootView.textView.text ?? ""
        let numLines = Int(rootView.textView.contentSize.height / (rootView.textView.font?.lineHeight ?? 0))
        let title = text.components(separatedBy: "\n").first
        var subtitle = ""
        if numLines > 1 {
            if let title = title {
                subtitle = String(text[title.endIndex...])
                subtitle.removeFirst()
                print(subtitle)
            }
        }
        return NoteModel(title: title ?? "", subtitle: subtitle)
    }
}
