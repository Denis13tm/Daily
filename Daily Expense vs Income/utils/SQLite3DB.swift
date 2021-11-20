
// App created by Otabek Tuychiev

import Foundation
import SQLite3

public class NotesDB {
    var db: OpaquePointer?
    var stmt: OpaquePointer?
    
    init() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("AppNotes.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            
        }

        /// Create Table
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS notes_list (id INTEGER PRIMARY KEY AUTOINCREMENT, title CHAR(255), body CHAR(255))", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            
        }
    }
    
    func addData(title: String, body: String) -> Bool {
        
        let titleNS: NSString = title as NSString
        let bodyNS: NSString = body as NSString
        
        let queryString = "INSERT INTO notes_list (title, body) VALUES (?,?)"

        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return false

        }

        //binding the parameters
        if sqlite3_bind_text(stmt, 1, titleNS.utf8String, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return false
           
        }
        if sqlite3_bind_text(stmt, 2, bodyNS.utf8String, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return false
            
        }
        
        //executing the query to insert values
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting hero: \(errmsg)")
            return false
        }

        return true
        
    }
    

    
    
    func getData() -> [Transaction]? {
        
        var notes = [Transaction]()
        
        /// get Data
        let queryStringg = "SELECT * FROM notes_list"
    
//        let getRow = "Select FROM notes_list WHERE title = 'Salom'"
        
        if sqlite3_prepare(db, queryStringg, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            
            guard let queryResultCol0 = sqlite3_column_text(stmt, 0) else {
                print("Query result is nil")
                return nil
            }
            
            guard let queryResultCol1 = sqlite3_column_text(stmt, 1) else {
                print("Query result is nil")
                return nil
            }
            guard let queryResultCol2 = sqlite3_column_text(stmt, 2) else {
                print("Query result is nil")
                //return nil
                return nil
            }
            
            let getId = String(cString: queryResultCol0)
            let getTitle = String(cString: queryResultCol1)
            let getBody = String(cString: queryResultCol2)
            
//            notes.append(Note(id: getId, title: getTitle, body: getBody))
        
        }
        
        return notes
    }
    
    
    func editRow(rowNumber: Int, editTo: String) {
        let rowNumberNS = String(rowNumber)
        
        let updateStatementString = "UPDATE notes_list SET title = '"+editTo+"' WHERE id = "+rowNumberNS+";"
        
        if sqlite3_prepare_v2(db, updateStatementString, -1, &stmt, nil) ==
              SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
              print("\nSuccessfully updated row.")
            } else {
              print("\nCould not update row.")
            }
          } else {
            print("\nUPDATE statement is not prepared")
          }
          sqlite3_finalize(stmt)

    }
    
    func delete(id: Int) {
        let idString = String(id)
        let deleteStatement = "DELETE FROM notes_list WHERE id = "+idString+";"

      
        if sqlite3_prepare_v2(db, deleteStatement, -1, &stmt, nil) == SQLITE_OK {
            
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("\nSuccessfully deleted row.")
            } else {
                print("\nCould not delete row.")
            }
        } else {
            print("\nDELETE statement could not be prepared")
      }
      
      sqlite3_finalize(stmt)
    }
}
