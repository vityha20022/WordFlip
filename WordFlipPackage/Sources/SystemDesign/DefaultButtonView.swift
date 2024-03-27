import UIKit

public final class DefaultButton: UIButton {
    private let text: String
    private let color: UIColor

    public init(text: String, color: BaseColorScheme) {
        self.text = text
        self.color = color.resolve()

        super.init(frame: .zero)

        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(self.text, for: .normal)
        // TODO: set settings size
        titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        backgroundColor = self.color
        layer.cornerRadius = 30
        layer.shadowRadius = ComponentMetrics.shadowRadius
        layer.shadowColor = BaseColorScheme.shadowColor.resolve().cgColor
        layer.shadowOffset = ComponentMetrics.shadowOffset
        layer.shadowOpacity = ComponentMetrics.shadowOpacity
        layer.masksToBounds = false
        setTitleColor(BaseColorScheme.buttonText.resolve(), for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
