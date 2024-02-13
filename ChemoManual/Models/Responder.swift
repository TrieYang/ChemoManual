//
//  Responder.swift
//  ChemoManual
//
//  Created by Trie Yang on 2023-12-03.
//

import Foundation
import Swift
import SwiftUI
import CryptoKit
import FMDB

struct DataModel: Codable, Hashable{
    var id: String
    var title: String
    var content: String
    var image: String!
    var time: String
    var type: String

  
}


func respond(message: String, senderTextReader: TextReader) {
    var textReader: TextReader = senderTextReader
    
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    let url = URL(string: "http://openapi.q88y.net/ai_chat.php")

    
    
    //让url = NSURL（string：urlString as String）
    var request : URLRequest = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    //.....
    //nn=hello  jm=md5(hello +"ewewweew")
    let nn = message
    let mm = md5(nn+"30dkeuju#$@$.1")
    
    
    let postString = "nn=" + nn + "&mm=" + mm + "&uid=-102"
    request.httpBody = postString.data(using: .utf8)
    let dataTask = session.dataTask(with: request) { data,response,error in
   
       //1：检查HTTP响应以获取成功的GET请求
       guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
       else {
          print("error: not a valid http response")
          return
       }

       switch (httpResponse.statusCode) {
          case 200:
             //成功的回应。
           print("hi")
           let str = String(data: data!, encoding: String.Encoding.utf8)
           print(str!)
           print(httpResponse.statusCode)
           textReader.insertText(textMessage: TextSet(message: str!, sender: false))
           print(str!)
             break
          case 400:
           print("hello")
             break
          default:
           let str = String(data: data!, encoding: String.Encoding.utf8)
           print("default is called")
           print(httpResponse.statusCode)


             break
       }
    }
    dataTask.resume()
}

func fetchDataFromURL(theDatabase: FMDatabase){
    

    
    var idQuery = "SELECT MAX(id) FROM post;"
    var lastId: Int32 = 0
    if let resultSet = try? theDatabase.executeQuery(idQuery, values: nil) {
        if resultSet.next() {
            lastId = resultSet.int(forColumnIndex: 0)
        }
        resultSet.close()
    }
    print(lastId)
        
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let url = URL(string: "http://localhost/demo/infoPage.php")
        if lastId != 0 {
            let url = URL(string: "http://localhost/demo/infoPage.php?lastId=" + String(lastId))
            print(url)
        }
    
    var request : URLRequest = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    

    
    

     let dataTask = session.dataTask(with: request) { data,response,error in
       
           //1：检查HTTP响应以获取成功的GET请求
           guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
           else {
              print("error: not a valid http response")
              return
           }

           switch (httpResponse.statusCode) {
              case 200:
                 //成功的回应。
              
               let decoder = JSONDecoder()
               do {
                   let yourDataArray = try decoder.decode([DataModel].self, from: data!)
                   for var dataModel in yourDataArray {
                       if let utf8data = dataModel.content.data(using: .utf8),
                          let chineseString = String(data: utf8data, encoding: .utf8)?.removingPercentEncoding {
                           dataModel.content = chineseString
                           insertIntoDB(theDatabase: theDatabase, dataModel: dataModel)
                       } else {
                           print("fail to convert")
                       }
                   }
                  
               } catch {
                   print(error)
               }
            
                 break
             case 400:
               print("hello")
                 break
              default:
               print("default is called")
                 break
           }
        }
    
        dataTask.resume()

}

func insertIntoDB(theDatabase: FMDatabase, dataModel: DataModel) {
    
    var insert = "INSERT INTO post(id, title, content, type) VALUES ("  + dataModel.id + ", '" + dataModel.title + "', '" + dataModel.content.replacingOccurrences(of: "'", with: "''") + "', '" + dataModel.type + "');"
    
    if dataModel.image != nil {
        downloadImage(url: "http://localhost/demo/upload/" + dataModel.image) { url in
            insert = "INSERT INTO post(id, title, content, image, type) VALUES ("  + dataModel.id + ", '" + dataModel.title + "', '" + dataModel.content.replacingOccurrences(of: "'", with: "''") + "', '" + url + "', '" + dataModel.type + "');"
            
            theDatabase.executeStatements(insert)
        }
    }
    
    let existQuery = "SELECT * FROM post WHERE id = " + dataModel.id
    var doExist: Bool = false
    if let resultSet = try? theDatabase.executeQuery(existQuery, values: nil) {
        if resultSet.next() {
            doExist = true
        }
        resultSet.close()
    }
    
    if doExist {
        insert = "UPDATE post SET id = "  + dataModel.id + ", title = '" + dataModel.title + "', content = '" + dataModel.content.replacingOccurrences(of: "'", with: "''") + "', type = '" + dataModel.type + "' WHERE id = " + dataModel.id + ";"
        if dataModel.image != nil {
            downloadImage(url: "http://localhost/demo/upload/" + dataModel.image) { url in
                
                insert = "UPDATE post SET id = "  + dataModel.id + ", title = '" + dataModel.title + "', content = '" + dataModel.content.replacingOccurrences(of: "'", with: "''") + "', image = '" + url + "', type = '" + dataModel.type + "' WHERE id = " + dataModel.id + ";"
                print("insert statement is : " + insert)
                
                theDatabase.executeStatements(insert)
                print(insert)
            }
            
        }
    } else {
            print("insert statement is : " + insert)
           
            theDatabase.executeStatements(insert)
        }
        
    
    
    
    
 
    
}

func md5(_ str: String) -> String {
    let data = str.data(using: .utf8)!
    let hash = Insecure.MD5.hash(data: data)
    return hash.map { String(format: "%02hhx", $0) }.joined()
}




class MyHttp: NSObject, URLSessionDelegate {
    // 使用URLSession请求数据
    func httpGet(request: URLRequest,  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let dataTask = session.dataTask(with: request, completionHandler: completionHandler)
          
        //使用resume方法启动任务
        dataTask.resume()
    }
     
    func urlSession(_ session:URLSession, didReceive challenge:URLAuthenticationChallenge, completionHandler:@escaping (URLSession.AuthChallengeDisposition,URLCredential?) -> Void) {
 
            guard challenge.protectionSpace.authenticationMethod == "NSURLAuthenticationMethodServerTrust"else {
                return
            }
 
            let credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(.useCredential,credential)
      }
}
