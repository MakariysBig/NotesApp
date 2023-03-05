import UIKit
import SnapKit
import Kingfisher

final class NewsCustomTableViewCell: UITableViewCell {
    
    //MARK: - Cell identifier
    
    static let identifier = "Cell"
    
    //MARK: - Properties
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let readLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.numberOfLines = 0
        label.text = "Read"
        label.textAlignment = .right
        label.isHidden = true
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var topStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timeLabel, readLabel])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 0
        stack.alignment = .center
        stack.heightAnchor.constraint(equalToConstant: 15).isActive = true
        stack.translatesAutoresizingMaskIntoConstraints = false
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
    
    //MARK: - Update cell
    
    func updateCell(model: News) {
        let image = model.modelImage
        if let url = URL(string: image) {
            self.image.kf.setImage(with: url)
        }
        timeLabel.text = model.modelDateTime
        descriptionLabel.text = model.modelTitle
        checkNewsIsRead(model: model)
    }
    
    func checkNewsIsRead(model: News) {
        if model.isRead {
            readLabel.isHidden = false
        } else {
            readLabel.isHidden = true
        }
    }
    
    //MARK: - Add subviews
    
    private func setup() {
        contentView.addSubview(image)
        contentView.addSubview(topStackView)
        contentView.addSubview(descriptionLabel)
        updateConstraintsIfNeeded()
    }
    
    //MARK: - Set constrains
    
    override func updateConstraints() {
        super.updateConstraints()
        
        image.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(72)
            $0.left.equalToSuperview().offset(14)
        }
        
        topStackView.snp.makeConstraints {
            $0.left.equalTo(image.snp.right).offset(14)
            $0.right.equalToSuperview().inset(10)
            $0.top.equalTo(image.snp.top)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(topStackView.snp.bottom).offset(6)
            $0.left.equalTo(image.snp.right).offset(14)
            $0.right.equalToSuperview().inset(10)
            $0.bottom.equalTo(image.snp.bottom)
        }
    }
}
