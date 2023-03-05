import UIKit
import Kingfisher

final class DescribeViewController: UIViewController {
    
    //MARK: - Properties

    private let repository = Repository()
    
    weak var delegate: ReadProtocol?
    private var news: News
    private var index: Int
    private var rootView: DescribeView {
        view as! DescribeView
    }
    
    //MARK: - Initialise
    
    init(news: News, index: Int) {
        self.news = news
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func loadView() {
        view = DescribeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.markNewsRead(index: index)
    }
    
    //MARK: - Private methods
    
    private func setup() {
        rootView.updateView(model: news)
    }
}
