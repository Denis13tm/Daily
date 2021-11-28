

import Foundation
import RealmSwift


public class Transaction: Object {
    
    @objc dynamic var type: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var icon: String = ""
    @objc dynamic var amount: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var notes: String = ""
    
}
