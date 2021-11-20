//
//  Category_Items.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 18/11/2021.
//

import Foundation

class Category_Items {
    var categoryItems = [Category]()
    
    init() {
        categoryItems.append(Category(icon: "banknote.fill", title: "Expecting Income"))
        categoryItems.append(Category(icon: "creditcard.fill", title: "Money Transfer"))
        categoryItems.append(Category(icon: "books.vertical.fill", title: "Books"))
        categoryItems.append(Category(icon: "house.fill", title: "Rent"))
        categoryItems.append(Category(icon: "car.fill", title: "Car Payment"))
        categoryItems.append(Category(icon: "graduationcap.fill", title: "Education"))
        categoryItems.append(Category(icon: "cart.fill", title: "Food"))
        categoryItems.append(Category(icon: "cross.case.fill", title: "Health Care"))
        categoryItems.append(Category(icon: "briefcase.fill", title: "Salary"))
        categoryItems.append(Category(icon: "building.columns", title: "Taxes"))
        categoryItems.append(Category(icon: "play.tv.fill", title: "Netflix Subscription"))
        categoryItems.append(Category(icon: "airplane", title: "Travel"))
        categoryItems.append(Category(icon: "bus.doubledecker", title: "Transportation Fee"))
        categoryItems.append(Category(icon: "figure.walk", title: "Activity"))
        categoryItems.append(Category(icon: "music.mic", title: "Entertainment"))
        categoryItems.append(Category(icon: "cart.fill", title: "Shopping"))
        categoryItems.append(Category(icon: "scissors", title: "Hair Cut"))
        categoryItems.append(Category(icon: "wrench.and.screwdriver.fill", title: "Tools"))
        
      
    }
}

