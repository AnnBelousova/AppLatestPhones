//
//  NetworkService2.swift
//  AppLatestPhones
//
//  Created by user214004 on 4/17/22.
//

import Foundation
import Foundation
import UIKit


protocol networkingDelegateProtocole2 {
    func imageDownloadedCorrectly(image : UIImage)
    func imageDidNotDownloadedCorrectly()
}

class NetworkService2 {
  
   static var Shared : NetworkService2 = NetworkService2()
    var delegate : networkingDelegateProtocole2?

    
    
    func fetchDataFromURLApple(completionHandler : @escaping (Result <[phones], Error>)->Void )  {
        
        let url = "https://api-mobilespecs.azharimm.site/v2/latest"
        //let url = "https://api-mobilespecs.azharimm.site/v2/brands/apple-phones-48?page=2"
        let urlObj = URL(string: url)!

        let task = URLSession.shared.dataTask(with: urlObj)
        { data, response, error in
            guard error == nil else {
                completionHandler(.failure(error!))
                return
            }
            guard let httpRespons = response as? HTTPURLResponse, (200...299).contains(httpRespons.statusCode) else {
                print ("Incorrect response ")
                
                //completionHandler(.failure(error!))
                return
            }
            
            if let jsonData = data {
                    print(jsonData)
              let decoder =  JSONDecoder()
                do {
               let result = try?
                    decoder.decode(phonesCollection.self, from: jsonData)
                    completionHandler(.success(result!.data.phones))
                    print(result)
                }
                catch {
                    print (error)
                }
            }
        }
        task.resume()
      
    }


  /*  func getImageApple(url: String , completionHandler : @escaping (Result <UIImage, Error>)->Void){
        let urlObj = URL(string: url)!
        let task = URLSession.shared.dataTask(with: urlObj)
               { data, response, error in
                      guard error == nil else {
                          completionHandler(.failure(error!))
                          return
                      }
                      guard let httpRespons = response as? HTTPURLResponse, (200...299).contains(httpRespons.statusCode) else {
                          print ("Incorrect response ")
                          return
                   }
                   if let imageData = data {
                       let phimage = UIImage(data: imageData)
                       completionHandler(.success(phimage!))
                      }
                  }
                  task.resume()

       }*/
   
   }
