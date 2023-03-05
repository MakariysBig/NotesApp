import UIKit
import SnapKit

final class MainCustomTableViewCell: UITableViewCell {
    
    //MARK: - Cell identifier
    
    static let identifier = "Cell"
    
    //MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "subtitle"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 0
        return stack
    }()
    
    //MARK: - Initialise

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Add subview
    
    private func setup() {
        backgroundColor = .clear
        addSubview(stackView)
        updateConstraintsIfNeeded()
    }
    
    //MARK: - Internal methods
    
    func updateCell(model: NoteModel) {
        titleLabel.text    = model.title
        
        if model.subtitle == "" {
            subtitleLabel.text = "There is no additional text"
        } else {
            subtitleLabel.text = model.subtitle
        }
    }
    
    //MARK: - Set constraints
    
    override func updateConstraints() {
        super.updateConstraints()
        
        stackView.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview().inset(6)
            $0.left.equalToSuperview().inset(14)
        }
    }
}
