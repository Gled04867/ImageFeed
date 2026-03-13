import UIKit

final class ImageListCell: UITableViewCell {
    static let reuseIdentifier = "ImageListCell"
    
    
    @IBOutlet weak var imageInCell: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var gradient: UIView!
    
    private let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.layoutIfNeeded()
        gradientLayer.frame = gradient.bounds
    }
    
    func setGradient() {
        
        
        let topColor = UIColor(red: 26.0/255.0, green: 27.0/255.0, blue: 24.0/255.0, alpha: 0).cgColor
        let bottomColor = UIColor(red: 26.0/255.0, green: 27.0/255.0, blue: 34.0/255.0, alpha: 1).cgColor
        
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        gradient.layer.insertSublayer(gradientLayer, at: 0)
    }
}
