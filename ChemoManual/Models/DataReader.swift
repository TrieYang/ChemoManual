//
//  DataReader.swift
//  ChemoManual
//
//  Created by Trie Yang on 2023-11-06.
//

import Foundation
import SwiftUI
import FMDB

struct DataSet: Hashable{
    var name: String
    var content: String
    var image: String
    var type: String
}

class DataReader: ObservableObject {
    @Published var name: [DataSet]
    var filteredSet: [DataSet] = []
    var searchResult: [DataSet] = []
    var searchedSet: [DataSet] = []
    var timer: Timer?
    
    let theDatabase = FMDatabase(path: "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!)/ChemoManualDB.db")
    
    
    init() {
        name = []
        openDB()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(checkPostTable), userInfo: nil, repeats: true)
    }
    
    @objc func checkPostTable() {
        if loadInitialData().isEmpty {
                fetchDataFromURL(theDatabase: theDatabase)
                
            } else {
                timer?.invalidate()
                timer = nil
                loadInitialData()
                
            }
    }
    func loadInitialData() -> [DataSet] {
        DispatchQueue.main.async {
            let selectQuery = "SELECT * FROM post"
            if let resultSet = try? self.theDatabase.executeQuery(selectQuery, values: nil) {
                while resultSet.next() {
                    let id = resultSet.int(forColumn: "id")
                    var item: DataSet = DataSet(name: resultSet.string(forColumn: "title") ?? "",
                                                content: resultSet.string(forColumn: "content") ?? "".replacingOccurrences(of: "'", with: "''"),
                                                image: resultSet.string(forColumn: "image") ?? "",
                                                type: resultSet.string(forColumn: "type") ?? "")
                    self.name.append(item)
                }
            }
        }
        return name
    }
    
    
    func openDB() {
        
//        let databasePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//        
//        let theDatabase = FMDatabase(path: "\(databasePath)/ChemoManualDB.db")
        print("is the database open")
        print(theDatabase.open())
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!)
   
        if !theDatabase.tableExists("post") {
            let createTable = "CREATE TABLE post(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, image TEXT, type TEXT);"
            print(theDatabase.executeStatements(createTable))

        }
        
        fetchDataFromURL(theDatabase: theDatabase)
        

        
        let selectQuery = "SELECT * FROM post"
        if let resultSet = try? theDatabase.executeQuery(selectQuery, values: nil) {
            while resultSet.next() {
                let id = resultSet.int(forColumn: "id")
                var item: DataSet = DataSet(name: resultSet.string(forColumn: "title") ?? "", content:  resultSet.string(forColumn: "content") ?? "".replacingOccurrences(of: "'", with: "''"), image: resultSet.string(forColumn: "image") ?? "", type: resultSet.string(forColumn: "type") ?? "")
                self.name.append(item)
            }
        }
        
    }
    
    func filterDB(typeParam: Type) -> [DataSet] {
//        let databasePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//        
//        let theDatabase = FMDatabase(path: "\(databasePath)/ChemoManualDB.db")
//        
//        print(theDatabase.open())
//        print(databasePath)
        
        let selectQuery2 = "SELECT * FROM post WHERE type = '" + typeParam.dataBaseName + "'"
        filteredSet = []
        if let resultSet2 = try? theDatabase.executeQuery(selectQuery2, values: nil) {
            while resultSet2.next() {
                let id2 = resultSet2.int(forColumn: "id")
                var item2: DataSet = DataSet(name: resultSet2.string(forColumn: "title") ?? "", content: resultSet2.string(forColumn: "content") ?? "".replacingOccurrences(of: "'", with: "''"), image: resultSet2.string(forColumn: "image") ?? "", type: resultSet2.string(forColumn: "type") ?? "")
                self.filteredSet.append(item2)
           
            }
        } else {
            print("can not execute filtering")
        }
        return filteredSet
    }
    
    func searchDB(keyWord: String) -> [DataSet] {
//        let databasePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//        
//        let theDatabase = FMDatabase(path: "\(databasePath)/ChemoManualDB.db")
        
//        print(theDatabase.open())
//        print(databasePath)
        
        let selectQuery3 = "SELECT * FROM post WHERE title LIKE '%" + keyWord + "%' OR content LIKE '%" + keyWord + "%'"
        searchedSet = []
        if let resultSet3 = try? theDatabase.executeQuery(selectQuery3, values: nil) {
            while resultSet3.next() {
                let id3 = resultSet3.int(forColumn: "id")
                var item3: DataSet = DataSet(name: resultSet3.string(forColumn: "title") ?? "", content: resultSet3.string(forColumn: "content") ?? "".replacingOccurrences(of: "'", with: "''"), image: resultSet3.string(forColumn: "image") ?? "", type: resultSet3.string(forColumn: "type") ?? "")
                self.searchedSet.append(item3)
               
                
            }
        } else {
            print("can not execute searching")
        }
        return searchedSet
    }


    
}
