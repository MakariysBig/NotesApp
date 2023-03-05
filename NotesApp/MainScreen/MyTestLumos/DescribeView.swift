import UIKit

final class DescribeView: UIView {
    
    //MARK: - Properties
    
    private let mainImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.numberOfLines = 0
        return label
    }()
    
    private let describeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, dateLabel, describeLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 5
        return stack
    }()
    
    //MARK: - Initialise
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Update view
    
    func updateView(model: News) {
        let image = model.modelImage
        if let url = URL(string: image) {
            mainImage.kf.setImage(with: url)
        }
        titleLabel.text    = model.modelTitle
        describeLabel.text = model.modelText
        dateLabel.text     = model.modelDateTime
    }
    
    //MARK: - Add subviews
    
    private func setup() {
        backgroundColor = .systemBackground
        addSubview(mainImage)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStack)
        setNeedsUpdateConstraints()
    }
    
    //MARK: - Set constraints
    
    override func updateConstraints() {
        super.updateConstraints()
        
        mainImage.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(mainImage.snp.bottom)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        mainStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.lessThanOrEqualTo(-10)
        }
    }
}
