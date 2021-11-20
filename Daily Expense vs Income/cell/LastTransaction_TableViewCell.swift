
import UIKit

class LastTransaction_TableViewCell: UITableViewCell {
    
    
    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var notes: UILabel!
    @IBOutlet var amout: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var cell_BackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cell_BackgroundView.layer.cornerRadius = 13.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
