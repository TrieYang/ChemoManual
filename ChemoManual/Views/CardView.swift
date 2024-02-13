//
//  Card.swift
//  ChemoManual
//
//  Created by Trie Yang on 2023-11-01.
//

import SwiftUI

struct CardInfo {
    var question: String
    var partialAnswer: String
    var image: String
}

struct CardView: View {
    
    var question: String = "What are you looking for?"
    var partialAnswer: String = "I am looking some hard-working basrista."
    var answer: String = "I am looking some hard-working basrista with at least 2 years of experience. It would be prefereable if you have some cashier experience as well. the shift is easy and I will call on you every week if we reach an agreenment."
    var image: String
   

    var body: some View {
            
            VStack(alignment: .leading,
                   spacing: 10) {
                
                HStack {
                    Text(question).font(.custom("hi", size: 24)).fontWeight(.medium).foregroundColor(Color.black).multilineTextAlignment(.leading)
                    Spacer()
                }
                if image == "" {
                    HStack {
                        
                        Text(partialAnswer + "...").font(.caption).foregroundColor(.black).fontWeight(.thin).multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
               
                
                if image != "" {
                    
                    
    
//                    if let imageTest = image2 {
//                                imageTest
//                                    .resizable()
//                                    .scaledToFit()
//                      
//                            } else {
//                                // Placeholder or loading indicator while downloading
//                                Text("Loading Image...")
//                                    
//                            }
                    
                    if let imageUrl = URL(string: image),
                                   let uiImage = UIImage(contentsOfFile: imageUrl.path) {
                                    // Display the local image
                                    Image(uiImage: uiImage)
                            .resizable().aspectRatio(contentMode: .fit).frame(maxWidth:.infinity).cornerRadius(10)
                                       
                                } else {
                                    // Placeholder or error message if the image cannot be loaded
                                    Text("loading image...")
                                }
                    
                    
//                    if let uiImage = UIImage(contentsOfFile:  image) {
//                                    Image(uiImage: uiImage)
//                            .resizable().aspectRatio(contentMode: .fit).frame(maxWidth:.infinity).cornerRadius(10)
//                        Text("image is shown")
//                                } else {
//                                    Text(image)
//                                    
//                                }
//                    Image(uiImage: UIImage(contentsOfFile: downloadImage(url: "http://192.168.1.103/demo/upload/" + image)) ?? UIImage())
                    
//                    AsyncImage(url: URL(string: "http://192.168.1.103/demo/upload/" + image)) { phase in
//                        if let imageDisplay = phase.image {
//                            imageDisplay.resizable().aspectRatio(contentMode: .fit).frame(maxWidth:.infinity).cornerRadius(10)// Displays the loaded image.
//                            
//                        } else if phase.error != nil {
//                            Color.red // Indicates an error.
//                            Text("http://192.168.1.103/demo/" + image)
//                        } else {
//                            Color.blue // Acts as a placeholder.
//                        }
                    //}
                        
                        
                }
                
            }
                   .padding(20)
                   .frame(maxWidth: UIScreen.main.bounds.width*cardWidth)
                   .background(Rectangle()
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2))
                   .padding(6)
                   
        
    }
    





}

func downloadImage(url: String, completion: @escaping (String) -> Void){
    var showingUrl = ""
//    guard let url = URL(string: url) else {
//        return "false downloading 2"
//    }
    guard let imageURL = URL(string: url) else {
            completion("false downloading")
            return
        }

//    URLSession.shared.dataTask(with: url) { data, _, error in
//        if let data = data, let uiImage = UIImage(data: data) {
//                showingUrl = saveImageToDocumentDirectory(data: data)
//        }
//    }.resume()
    
    URLSession.shared.dataTask(with: imageURL) { data, _, error in
        if let data = data, let uiImage = UIImage(data: data) {
            showingUrl = saveImageToDocumentDirectory(data: data)
            completion(showingUrl)
        } else {
            completion("Error downloading image")
        }
    }.resume()

   
}

func saveImageToDocumentDirectory(data: Data) -> String {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    // Create a unique filename
    let fileName = UUID().uuidString + ".jpg"
    let fileURL = documentsDirectory.appendingPathComponent(fileName)

    do {
        // Save the image data to the file
        try data.write(to: fileURL)
        print("Image saved to: \(fileURL)")
        print("absolute string is" + fileURL.absoluteString)
        return fileURL.absoluteString
    } catch {
        print("Error saving image: \(error)")
        return "false doanloading"
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
      //CardView()
        Text("test")
    }
}

func hello() {
    print("hello")
}


