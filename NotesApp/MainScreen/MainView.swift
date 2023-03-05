import UIKit
import SnapKit

final class MainView: UIView {
    
    //MARK: - Properties
    
    let tableView: UITableView = {
        let view = UITableView()
        view.register(MainCustomTableViewCell.self, forCellReuseIdentifier: MainCustomTableViewCell.identifier)
        view.rowHeight = 60
        view.tableHeaderView = UIView()
        return view
    }()
    
    //MARK: - Initialise

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Add subview
    
    private func setup() {
        backgroundColor = .systemBackground
        addSubview(tableView)
        updateConstraintsIfNeeded()
    }
    
    //MARK: - Set constraints
    
    override func updateConstraints() {
        super.updateConstraints()
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
