//
//  NetworkService.swift
//  AppLatestPhones
//
//  Created by user214004 on 4/15/22.
//

import Foundation
import UIKit


protocol networkingDelegateProtocole {
    func imageDownloadedCorrectly(image : UIImage)
    func imageDidNotDownloadedCorrectly()
}

class NetworkService {
  
   static var Shared : NetworkService = NetworkService()
    var delegate : networkingDelegateProtocole?

    func fetchDataFromURL(completionHandler : @escaping (Result <[phones], Error>)->Void )  {
      
        let url = "https://api-mobilespecs.azharimm.site/v2/latest"
        
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
                    
                }
                catch {
                    print (error)
                }
            }
        }
        task.resume()
      
    }
    
    func fetchDataFromURLApple(completionHandler : @escaping (Result <[phones], Error>)->Void )  {
            
        let url = "https://api-mobilespecs.azharimm.site/v2/brands/apple-phones-48?page=2"
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
               let result = try
                    decoder.decode(phonesCollection.self, from: jsonData)
                    completionHandler(.success(result.data.phones))
                    
                }
                catch {
                    print (error)
                }
            }
        }
        task.resume()
      
    }
    
    func getImage(url: String , completionHandler : @escaping (Result <UIImage, Error>)->Void){
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

       }
    
}


