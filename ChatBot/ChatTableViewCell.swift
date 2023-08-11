import UIKit

class ChatTableViewCell: UITableViewCell {
    
    var message: String? {
        didSet {
            messageLabel.text = message

            // Call layoutIfNeeded to ensure the label's constraints are updated before calculating the size
            contentView.layoutIfNeeded()
            let labelSize = messageLabel.sizeThatFits(CGSize(width: messageLabel.bounds.width, height: .greatestFiniteMagnitude))

            // Adjust the cell height based on the label's required height and some extra padding
            let requiredHeight = labelSize.height + 16 // You can adjust the padding as needed
            contentView.bounds.size.height = requiredHeight
        }
    }

    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()

    var isUserMessage: Bool = false {
        didSet {
            messageLabel.textAlignment = isUserMessage ? .right : .left
            messageLabel.textColor = isUserMessage ? .blue : .black
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }

    private func setupSubviews() {
        contentView.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        messageLabel.text = nil
    }
}
