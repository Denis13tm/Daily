//
//  CategoryCell.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 18/11/2021.
//

import Foundation
import RealmSwift

 class Category {
    
    var icon: String?
    var title: String?
    
    
    init(icon: String, title: String) {
        self.icon = icon
        self.title = title
    }
    
}
