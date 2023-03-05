import UIKit

enum TypeEnum {
    case change
    case create
}

final class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    private let repository = NoteRepository()
    private var notesArray = [NoteModel]()
    private var rootView: MainView {
        view as! MainView
    }
    
    //MARK: - Livecycle
    
    override func loadView() {
        super.loadView()
        view = MainView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        notesArray = repository.getAllNoteModels()
        notesArray.reverse()
        rootView.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK: - Methods
    
    private func setup() {
        setupDelegate()
        setupNavigationBar()
    }

    private func setupDelegate() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        let image = UIImage(systemName: "plus")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(didTapNewNoteButton))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "My notes"
    }
    
    //MARK: - Actions
    
    @objc private func didTapNewNoteButton() {
        let note = NoteModel(title: "", subtitle: "")
        let vc = NoteViewController(note: note, type: .create)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Extension: UITableViewDelegate & UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCustomTableViewCell.identifier, for: indexPath) as? MainCustomTableViewCell else { return UITableViewCell() }
        cell.updateCell(model: notesArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = NoteViewController(note: notesArray[indexPath.row], type: .change)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = notesArray[indexPath.row].id
            notesArray.remove(at: indexPath.row)
            repository.deleteFromDB(id: id)
            tableView.reloadData()
        }
    }
}

