//
//  Category_Items.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 18/11/2021.
//

import Foundation

class Category_Items {
    var categoryItems = [Category]()
    
    var exp_Income = "exp_Income".localized()
    var moneyTransfer = "moneyTransfer".localized()
    var books = "books".localized()
    var rent = "rent".localized()
    var carPayment = "carPayment".localized()
    var education = "education".localized()
    var food = "food".localized()
    var healthCare = "healthCare".localized()
    var salary = "salary".localized()
    var taxes = "taxes".localized()
    var netflixSubs = "netflixSubs".localized()
    var travel = "travel".localized()
    var transportation = "transportation".localized()
    var activity = "activity".localized()
    var entertainment = "entertainment".localized()
    var shopping = "shopping".localized()
    var hairCut = "hairCut".localized()
    var tools = "tools".localized()
    
    
    init() {
        
        categoryItems.append(Category(icon: "banknote.fill", title: exp_Income))
        categoryItems.append(Category(icon: "creditcard.fill", title: moneyTransfer))
        categoryItems.append(Category(icon: "books.vertical.fill", title: books))
        categoryItems.append(Category(icon: "house.fill", title: rent))
        categoryItems.append(Category(icon: "car.fill", title: carPayment))
        categoryItems.append(Category(icon: "graduationcap.fill", title: education))
        categoryItems.append(Category(icon: "cart.fill", title: food))
        categoryItems.append(Category(icon: "cross.case.fill", title: healthCare))
        categoryItems.append(Category(icon: "briefcase.fill", title: salary))
        categoryItems.append(Category(icon: "building.columns", title: taxes))
        categoryItems.append(Category(icon: "play.tv.fill", title: netflixSubs))
        categoryItems.append(Category(icon: "airplane", title: travel))
        categoryItems.append(Category(icon: "bus.doubledecker", title: transportation))
        categoryItems.append(Category(icon: "figure.walk", title: activity))
        categoryItems.append(Category(icon: "music.mic", title: entertainment))
        categoryItems.append(Category(icon: "cart.fill", title: shopping))
        categoryItems.append(Category(icon: "scissors", title: hairCut))
        categoryItems.append(Category(icon: "wrench.and.screwdriver.fill", title: tools))
      
    }
}

