import UIKit
import SystemDesign

final class DefaultTableViewCell: UITableViewCell, CustomCellProtocoll {
    private let viewAtCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1 / UIScreen.main.scale
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.layer.shadowRadius = 3
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        view.layer.shadowOpacity = 1
        view.layer.masksToBounds = false
        return view
    }()
    
    private let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(viewAtCell)
        
        NSLayoutConstraint.activate([
            viewAtCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            viewAtCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            viewAtCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            viewAtCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10)
        ])
        
        configureViewInUIView()
    }
    
    required init?(coder Decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewInUIView() {
        viewAtCell.addSubview(leftImageView)
        viewAtCell.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            leftImageView.leadingAnchor.constraint(equalTo: viewAtCell.leadingAnchor, constant: 10),
            leftImageView.centerYAnchor.constraint(equalTo: viewAtCell.centerYAnchor),
            leftImageView.widthAnchor.constraint(equalToConstant: 40),
            leftImageView.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: viewAtCell.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: viewAtCell.topAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: viewAtCell.bottomAnchor, constant: -20)
        ])
    }
    
    func configure(image: UIImage?, text: String?, isOn: Bool, closureForAction: ((Int) -> Void)?) {
        leftImageView.image = image
        titleLabel.text = text
    }
}

