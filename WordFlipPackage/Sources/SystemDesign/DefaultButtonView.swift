
import UIKit

public final class DefaultButton: UIButton {
    private let text: String
    private let color: UIColor
    
    public init(text: String, color: BaseColorScheme) {
        self.text = text
        self.color = color.setup()
        
        super.init(frame: .zero)
        
        setup()
    }
    
    private func setup() {
        setTitle(self.text, for: .normal)
        // TODO: set settings size
        titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        backgroundColor = self.color
        layer.cornerRadius = 30
        layer.shadowRadius = 3
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowOpacity = 0.35
        layer.shadowRadius = 0.0
        layer.masksToBounds = false
        setTitleColor(BaseColorScheme.buttonText.setup(), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
