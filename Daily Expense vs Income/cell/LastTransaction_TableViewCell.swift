
import UIKit

class LastTransaction_TableViewCell: UITableViewCell {
    
    
    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var notes: UILabel!
    @IBOutlet var amout: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var cell_BackgroundView: UIView!
    
    @IBOutlet var upcoming_Label: UILabel!
    @IBOutlet var checkBtn_BV: UIView!
    @IBOutlet var checkBtn_InsideBV: UIView!
    
    @IBOutlet var upcomingReminderView: UIStackView!
    
    var actionDelegate: CellActionDelegate?
        var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cell_BackgroundView.layer.cornerRadius = 13.0
        checkBtn_BV.layer.cornerRadius = checkBtn_BV.bounds.height / 2
        checkBtn_InsideBV.layer.cornerRadius = checkBtn_InsideBV.bounds.height / 2
        overrideUserInterfaceStyle = .light
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    
    
    @IBAction func checkBtn_Action(_ sender: Any) {
        if let delegate = self.actionDelegate{
        
            delegate.didButtonTapped(index: index!)
      }
    }
    
}


protocol CellActionDelegate{
    func didButtonTapped(index: Int)
}

extension AllTransactions_ViewController: CellActionDelegate{
 func didButtonTapped(index: Int) {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storybord.instantiateViewController(withIdentifier: "AllTransactions_ViewController") as? AllTransactions_ViewController else{
            fatalError("Could not finc another view controller")
        }
        self.present(controller, animated: true, completion: nil)
    }
}
