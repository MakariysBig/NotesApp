import UIKit

final class NewsViewController: UIViewController {
    
    //MARK: - Properties
    
    private var newsArray = [News]()
    private var rootView: NewsView {
        view as! NewsView
    }
        
    private let repository = Repository()
    
    //MARK: - Livecycle
    
    override func loadView() {
        view = NewsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Methods
    private func setup() {
        title = "News"
        setupRefreshControl()
        setupDelegate()
        startSpinner()
        getData()
    }
    
    private func getData() {
        repository.getNews { result in
            switch result {
            case .success(let data):
                self.newsArray = data.items
                self.rootView.tableView.reloadData()
                self.stopSpinner()
                self.rootView.refreshControl.endRefreshing()
            case .failure(let failure):
                print("Error lesson: \(failure)")
                self.stopSpinner()
            }
        }
    }
    
    private func setupDelegate() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    private func startSpinner() {
        rootView.spinner.isHidden = false
        rootView.spinner.startAnimating()
    }
    
    private func stopSpinner() {
        rootView.spinner.isHidden = true
        rootView.spinner.stopAnimating()
    }
    
    private func setupRefreshControl() {
        rootView.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    //MARK: - Actions
    
    @objc private func refreshData() {
        newsArray = [News]()
        rootView.tableView.reloadData()
        getData()
    }
}

//MARK: - Extension: UITableViewDelegate & UITableViewDataSource

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCustomTableViewCell.identifier, for: indexPath) as! NewsCustomTableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .blue
        cell.updateCell(model: newsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DescribeViewController(news: newsArray[indexPath.row], index: indexPath.row)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Extension: ReadProtocol

extension NewsViewController: ReadProtocol {
    func markNewsRead(index: Int) {
        newsArray[index].isRead = true
        rootView.tableView.reloadData()
    }
}
