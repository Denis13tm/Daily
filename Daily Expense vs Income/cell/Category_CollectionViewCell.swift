//
//  Category_CollectionViewCell.swift
//  Daily Expense vs Income
//
//  Created by 13 Denis on 18/11/2021.
//

import UIKit

class Category_CollectionViewCell: UICollectionViewCell {

    @IBOutlet var collectionCell_BV: UIView!

    @IBOutlet var image: UIImageView!
    @IBOutlet var title: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionCell_BV.layer.cornerRadius = 13.0
        modifierUI(ui: collectionCell_BV)
        overrideUserInterfaceStyle = .light
    }
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.gray.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 5.0
    }

}
