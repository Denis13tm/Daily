

import Foundation
import RealmSwift


public class Transaction: Object {
    
    @objc dynamic var type: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var icon: String = ""
    @objc dynamic var amount: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var notes: String = ""
    
    @objc dynamic var isPresent: Bool = false
    @objc dynamic var isUpcoming: Bool = false
    
    @objc dynamic var year: Int = 0
    @objc dynamic var month: Int = 0
    @objc dynamic var day: Int = 0
    @objc dynamic var hour: Int = 0
    @objc dynamic var minute: Int = 0
    
    
    @objc dynamic var uuid: String = ""
    
}
