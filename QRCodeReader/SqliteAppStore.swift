//
//  SqliteAppStore.swift
//  QRCodeReader
//
//  Created by VijayKumar, Vipin on 02/11/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation
import SQLite

class SqliteAppStore{
    static let instance = SqliteAppStore()
    private let db: Connection?
    
    private let registeredList = Table("registeredList")
    private let id = Expression<Int64>("id")
    private let email = Expression<String?>("email")
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!

        do {
            db = try Connection("\(path)/techedRegistrations.sqlite3")
            print ("Opened Database")
        } catch {
            db = nil
            print ("Unable to open database")
        }

        createTable()
    }
    
    func createTable() {
        do {
            try db!.run(registeredList.create(ifNotExists: true) { table in
           // table.column(id, primaryKey: true)
            table.column(email, unique: true)
            //table.column(email, primaryKey: true)
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    func registerNew (cEmail: String ) -> Int64? {
        do {
            let insert = registeredList.insert(email <- cEmail)
            let id = try db!.run(insert)

            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    func registerNewVoid (cEmail: String ) {
          do {
              let insert = registeredList.insert(email <- cEmail)
              try db!.run(insert)

            //  return id
          } catch {
              print("Insert failed")
            //  return -1
          }
      }
 
    
    func entryExists(remail: String)-> Bool{
        print("Entering exists loop")
        do {
            let count = try db!.scalar(registeredList.filter(email == remail).count)
            print ("Entry Value = " + String(count))
            if count.datatypeValue > 0 {
                return true
            }
            return false
        }catch {
            print("DB Error")
            
        }
        return false
    }
    
}
