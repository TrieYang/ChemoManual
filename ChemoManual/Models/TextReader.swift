//
//  TextReader.swift
//  ChemoManual
//
//  Created by Trie Yang on 2023-11-06.
//

import Foundation
import SwiftUI
import FMDB

struct TextSet: Hashable {
    var message: String
   // var content: String
    var sender: Bool
}

class TextReader: ObservableObject, Identifiable {

    
    @Published var messageSet: [TextSet]
    var filteredSet: [DataSet] = []
    var searchResult: [DataSet] = []
    var searchedSet: [DataSet] = []
    
    
    init() {
        messageSet = []
        openDB()
        
        
    }
    
    
    func openDB() {
        
        let databasePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let theDatabase = FMDatabase(path: "\(databasePath)/ChemoManualDB.db")
        
        print(theDatabase.open())
        print(databasePath)
        
        if !theDatabase.tableExists("conversation") {
            let createTable = "CREATE TABLE conversation(id INTEGER PRIMARY KEY AUTOINCREMENT, message TEXT, sender BOOL);"
            let insertInitial = "INSERT INTO conversation(message, sender) VALUES ('Hi, this is your personal chemotherapy assistant powered by ChatGPT, how can I help you today?', 1);"
            print(theDatabase.executeStatements(createTable))
            
            
        }
   
        
        let selectQuery = "SELECT * FROM conversation"
        if let resultSet = try? theDatabase.executeQuery(selectQuery, values: nil) {
            while resultSet.next() {
               // let id = resultSet.int(forColumn: "id")
                var item: TextSet = TextSet(message: resultSet.string(forColumn: "message") ?? "", sender: resultSet.bool(forColumn: "sender"))
                self.messageSet.append(item)
                
            }
        } else {
            
        }
        
    }
    
    func readDB() {
        

        let databasePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let theDatabase = FMDatabase(path: "\(databasePath)/ChemoManualDB.db")
        theDatabase.open()
        print(databasePath)
        
        let selectQuery = "SELECT * FROM conversation"
        messageSet = []
        if let resultSet = try? theDatabase.executeQuery(selectQuery, values: nil) {
            while resultSet.next() {
               // let id = resultSet.int(forColumn: "id")
                var item: TextSet = TextSet(message: resultSet.string(forColumn: "message") ?? "", sender: resultSet.bool(forColumn: "sender"))
                self.messageSet.append(item)
            }
        } else {
        }
        
    }

    
    func insertText(textMessage: TextSet){
        let databasePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let theDatabase = FMDatabase(path: "\(databasePath)/ChemoManualDB.db")
        
        print(theDatabase.open())
        print(databasePath)
        
        let senderBool = String(textMessage.sender ? 1 : 0)
        let part = textMessage.message.replacingOccurrences(of: "'", with: "''") + "'," + senderBool
        let selectQuery3 = "INSERT INTO conversation(message, sender) VALUES ('" + part + ");"
        print(selectQuery3)
        if theDatabase.executeStatements(selectQuery3) {
            //DispatchQueue.main.async {
                self.messageSet.append(textMessage)
            //}
        }
        //readDB()
        print("message set is:")
        print(messageSet)
        theDatabase.close()
    }


    
}


