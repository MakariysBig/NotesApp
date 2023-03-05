import UIKit
import SnapKit

final class NoteView: UIView {
    
    //MARK: - Properties
    
    let textView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 18)
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
    
    //MARK: - Internal methods
    
    func updateView(model: NoteModel, type: TypeEnum) {
        if type == .change {
            textView.text = model.title + "\n" + model.subtitle
        }
    }
    
    //MARK: - Add subviews
    
    private func setup() {
        backgroundColor = .systemBackground
        addSubview(textView)
        setNeedsUpdateConstraints()
    }
    
    //MARK: - Set constraints
    
    override func updateConstraints() {
        super.updateConstraints()
        
        textView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
