import UIKit

final class UserTableViewCell: UITableViewCell, CustomCellProtocoll {
    private let viewAtCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    private let pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(viewAtCell)
        
        NSLayoutConstraint.activate([
            viewAtCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            viewAtCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            viewAtCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            viewAtCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20)
        ])
        
        configureViewInUIView()
    }
    
    private func configureViewInUIView() {
        viewAtCell.addSubview(pictureImageView)
        viewAtCell.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            pictureImageView.centerXAnchor.constraint(equalTo: viewAtCell.centerXAnchor),
            pictureImageView.topAnchor.constraint(equalTo: viewAtCell.topAnchor, constant: 10),
            pictureImageView.widthAnchor.constraint(equalTo: viewAtCell.widthAnchor, multiplier: 1/3),
            pictureImageView.heightAnchor.constraint(equalTo: viewAtCell.widthAnchor, multiplier: 1/3),
            
            usernameLabel.leadingAnchor.constraint(equalTo: viewAtCell.leadingAnchor, constant: 10),
            usernameLabel.trailingAnchor.constraint(equalTo: viewAtCell.trailingAnchor, constant: -10),
            usernameLabel.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 10),
            usernameLabel.bottomAnchor.constraint(equalTo: viewAtCell.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder Decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pictureImageView.layer.cornerRadius = pictureImageView.layer.frame.width / 2
    }
    
    func configure(image: UIImage?, text: String?, isOn: Bool?) {
        pictureImageView.image = image
        usernameLabel.text = text
        
        if traitCollection.userInterfaceStyle == .light {
            usernameLabel.textColor = .black
        } else {
            usernameLabel.textColor = .white
        }
    }
}
