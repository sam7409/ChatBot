import UIKit

class ChatCollectionViewCell: UICollectionViewCell {
    // Define the view and label to be used in the cell
    private let customView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 300))
        view.backgroundColor = UIColor.systemIndigo // You can change the background color as needed
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // Allow the label to have multiple lines
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16) // Customize the font as needed
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add the view and label to the cell's content view
        contentView.addSubview(customView)
        customView.addSubview(label)
        
        // Adjust the constraints to make the label fill the entire view
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: customView.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: customView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: customView.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: customView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public method to update the label text
    
    func setLabelText(_ text: String) {
        label.text = text
    }
}
